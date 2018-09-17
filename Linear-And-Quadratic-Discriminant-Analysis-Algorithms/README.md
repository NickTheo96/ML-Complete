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
