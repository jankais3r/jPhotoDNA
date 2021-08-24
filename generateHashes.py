#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import glob
import time
import base64
import datetime
import subprocess
import multiprocessing

inputFolder = r'C:\images\to\be\hashed'

def generateHash(imageFile):
	workerId = multiprocessing.current_process().name
	with open(os.path.join(outputFolder, workerId + '.txt'), 'a', encoding = 'utf8') as outputFile:
		result = subprocess.run([os.path.join(os.getcwd(), 'jPhotoDNA.exe') , os.path.join(os.getcwd(), 'PhotoDNAx64.dll'), imageFile], stdout = subprocess.PIPE)
		fileName = result.stdout.decode('utf-8').split('|')[0]
		hashString = result.stdout.decode('utf-8').split('|')[1].replace('\r\n', '')

		hashList = hashString.split(',')
		for i, hashPart in enumerate(hashList):
			hashList[i] = int(hashPart).to_bytes((len(hashPart) + 7) // 8, 'big')
		hashBytes = b''.join(hashList)
		#print(fileName + ',' + base64.b64encode(hashBytes).decode('utf-8'))
		
		with open(os.path.join(outputFolder, workerId + '.txt'), 'a', encoding = 'utf8') as outputFile:
			outputFile.write(fileName + ',' + base64.b64encode(hashBytes).decode('utf-8') + '\n')

if __name__ == '__main__':
	outputFolder = os.getcwd()
	if (inputFolder == r'C:\images\to\be\hashed'):
		print('Please update the input folder path on row 12.')
		quit()
	startTime = time.time()
	print('Generating hashes for all images under ' + inputFolder)
	
	p = multiprocessing.Pool()
	print('Starting processing using ' + str(p._processes) + ' threads.')
	imageCount = 0
	images = glob.glob(os.path.join(inputFolder, '**', '*.jp*g'), recursive = True)
	images.extend(glob.glob(os.path.join(inputFolder, '**', '*.png'), recursive = True))
	images.extend(glob.glob(os.path.join(inputFolder, '**', '*.gif'), recursive = True))
	images.extend(glob.glob(os.path.join(inputFolder, '**', '*.bmp'), recursive = True))
	for f in images:
		imageCount = imageCount + 1
		p.apply_async(generateHash, [f])
	p.close()
	p.join()
		
	allHashes = []
	for i in range(p._processes):
		try:
			workerId = 'SpawnPoolWorker-' + str(i + 1)
			with open(os.path.join(outputFolder, workerId + '.txt'), 'r', encoding = 'utf8') as inputFile:
				fileContents = inputFile.read().splitlines()
			allHashes.extend(fileContents)
			os.remove(os.path.join(outputFolder, workerId + '.txt'))
			#print('Merged the ' + workerId + ' output.')
		except FileNotFoundError:
			#print(workerId + ' not used. Skipping.')
			pass
	
	with open(os.path.join(outputFolder, 'hashes.csv'), 'w', encoding = 'utf8', errors = 'ignore') as f:
		for word in allHashes:
			f.write(str(word) + '\n')
	
	print('Results saved into ' + os.path.join(outputFolder, 'hashes.csv'))
	print('Generated hashes for ' + f'{imageCount:,}' + ' images in ' + str(int(round((time.time() - startTime)))) + ' seconds.')