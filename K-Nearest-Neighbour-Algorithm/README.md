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
