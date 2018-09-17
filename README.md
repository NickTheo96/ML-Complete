# Machine Learning LabScripts
## Outline of Repositry ##
These are a collection of code created during the Machine Learning Module. The folder Scripts is a collection of the lab scripts, K-Nearest-Neighbour-Algorithm contains an implementation of the Knn algorithm, Kernal-Ridge-Regression-Algorithm the krr algorithm and finally, Linear-And-Quadratic-Discriminant-Analysis-Algorithms contain implementations of LDA and QDA algorithms

## Outline of Course ##

* Week 1: Introduction to machine learning and to R
* Week 2: Nearest Neighbours and k-Nearest Neighbours 
* Week 3: Linear regression: simple and multiple linear regression, interaction terms, RSE and R^2 static
* Week 4: Polynomial regression
* Week 5: Discriminant Analysis: Implementing LDA and QDA, ROC curve analysis
* Week 6: Model selection: Forward and backward stepwise selection
* Week 7: Ridge regression and the Lasso
* Week 8: Non-linear modelling: Polynomial regression and step functions, Splines, Generalized additive models (GAMs)
* Week 9: Kernel Methods: polynomial and radial kernels and Kernel Ridge Regression
* Week 10: Support Vector Machines

# KNN algorithm created from first principles #
## Outline of Project ##
This is a repository implementing KNN (the first machine learning algorithms I learnt) to predict the classification of various things. 

First, the iris.txt was used. In this dataset, an Iris flower is either an Iris setosa or Iris virginica classified as +1 or -1 respectively. Which is the target attribute given in the fifth column of the dataset. The first four columns are attributes describing sepal length, sepal width, petal length, and petal width in cm. There were 100 samples which were split into 70-30 for the train and test set respectively. The algorithm correctly predicted the 30 test classifications.

ionosphere.txt contains data collected by a radar system in Goose Bay, Labrador. This system consists of a co-phased array of 16 high-frequency antennas with a total transmitted power on the order of 6.4 kilowatts. The last number in the line describes the classification: +1 radar returns are those showing evidence of some type of structure in the ionosphere; -1 returns are those that do not. The first 200 rows were used the training set and the remaining 265 rows were used as the test set.

USPS.txt contains normalized handwritten digits, automatically scanned from envelopes by the US Postal Service. USPSsubset.txt is its subset. The original scanned digits are binary and of different sizes and orientations however, the images have been deslanted and size normalized, resulting in 16 * 16 grayscale images. The datasets are in two seperate files with each row consisting of the 256 grayscale values for the pixels followed by the true label 0-9. The data set consisted of two parts, 7291 training observations and 2007 test observations merged into the file USPS.txt. My knn algorithm correctly outputed a 10 x 10 confusion matrix identical to the knn function in R (albeit at a much slower rate).

## How to run the file ##
to run the algorithm for a given dataset, simply change the dataset that is read in on line 9 to the desired text file and the trainlength on line 12 to the desired number and run the code. The confusion matrix variable is what is outputted.

## Description of the file structure ##

The datasets are:
 * iris.txt
 * ionosphere.txt
 * USPS.txt
 * USPSsubset.txt
 
The knn algorithm can be run by running nn.R by specifying the desired dataset that will be used within the nn.R file itself as specified above.

## Library Required: ##
* class (to run the built in knn function in R to compare results with my code)
<p>

## Examples ##
An example of how to run the code is included in nn.R for the ionosphere dataset.

# LDA and QDA algorithms created from first principles #
## Outline of Project ##

This is a repository implementing LDA and QDA to predict the classification of various things.

First, the iris.txt was used. In this dataset, an Iris flower is either an Iris setosa or Iris virginica classified as +1 or -1 respectively. Which is the target attribute given in the fifth column of the dataset. The first four columns are attributes describing sepal length, sepal width, petal length, and petal width in cm. There were 100 samples which were split into 70-30 for the train and test set respectively. The algorithm correctly predicted the 30 test classifications.

ionosphere.txt contains data collected by a radar system in Goose Bay, Labrador. This system consists of a co-phased array of 16 high-frequency antennas with a total transmitted power on the order of 6.4 kilowatts. The last number in the line describes the classification: +1 radar returns are those showing evidence of some type of structure in the ionosphere; -1 returns are those that do not. The first 200 rows were used the training set and the remaining 265 rows were used as the test set.

## How to run the file ##
to run an algorithm, simply run either: LDA1attribute.R, LDAnattributes.R or QDAnattributes.R to run the model on the iris dataset for LDA for one attribute, LDA for n attributes or QDA for n attributes respectively.

For a given dataset, simply change the dataset that is read in to the desired text file and the trainlength to the desired number and run the code. The confusion matrix variable is what is outputted as the result.

## Description of the file structure ##

The datasets are:
 * iris.txt
 * ionosphere.txt
 
 The executable files are:
 * LDA1attribute.R
 * LDAnattributes.R
 * QDAnattributes.R
 
The algorithmx can be run by running one of the executable files by specifying the desired dataset that will be used within the file itself as specified above.

## Library Required: ##
* NA

## Examples ##
An example of how to run the code is included in all the excutable files for the iris dataset.

# Kernal Ridge Regression Algorithm
Implementation of kernel ridge regression using a polynomial and radial kernal
## Outline of Project ##

This is a repository implementing KRR (Kernal Ridge Regression) to predict the classification of various things. The dataset is included in the reposirory but it can also be found [here.](http://www-bcf.usc.edu/~gareth/ISL/Advertising.csv). The first column is the column id, the second is the advetising budget of the product for TV, the third the advertising budget for radio, the fourth the advertising budged for newspaper and the final column the sales of the product. KRR using a polynomial kernel was used to predict the sales of the product for different budges for TV, radio and newspaper advertising. 

## How to run the code ##
polynomial.R is the impelemtation of a polynomial kernel that when run loads in the Advertising.csv data and outputs the predictions.

