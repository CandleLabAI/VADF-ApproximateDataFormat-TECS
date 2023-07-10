VADF: Versatile Approximate Data Formats. 
This is a collaborative research between IIT Kanpur, IIT Roorkee and TCS Research Lab Mumbai. 

About the files: 
vadf.m file is for evaluating VADF without any soft-error. 
vadf_1b.m file is for evaluating VADF with 1b soft-error. 
KNN_SVM_DNN.m and image_sharpening_smoothening.m files are for evaluating VADF in those applications. 
KNN_SVM_DNN.m requires two csv files for MNIST dataset, that can be downloaded from https://www.kaggle.com/datasets/oddrationale/mnist-in-csv?resource=download. 

Parameters, N = no. of total bits
		k = signifier bits after leading one-bit
		m = log(N) with base 2
		p = parity bit (0 for no error and 1 for error)
		e = error correcting bits 
		
Compressed bits (CB) = p+(m+e)+k
		         = 1+log(N)+e+k

Compression factor (CF) = N/CB
			      = N/(1+log(N)+e+k)

Example: 
32-bit architecture (N=32, m=5):
	CB= 1+5+e+k

		for k=2, e=0  => CB = 8 bits, CF = 4
		for k=3, e=1  => CB = 10 bits, CF = 3.2
		for k=4, e=2  => CB = 12 bits, CF = 2.67
		for k=5, e=3  => CB = 14 bits, CF = 2.28
		for k=6, e=4  => CB = 16 bits, CF = 2
	
	If you use this code, please cite this paper. 
	
	@article {mishra2023vadf,
	title            = {{VADF: Versatile Approximate Data Formats for Energy-Efficient Computing}},
	year             = "2023",
	author           = "Vishesh Mishra and Sparsh Mittal and Neelofar Hassan and Rekha Singhal and Urbi Chatterjee",
	journal          = "ACM Transactions on Embedded Computing Systems (TECS)",
	}
	
	Support for this software will be provided on a best-effort basis. 
	Contact the corresponding author: Sparsh Mittal (sparsh.mittal@ece.iitr.ac.in).
