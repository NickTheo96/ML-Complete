# KNN algorithm created from first principles #
## Outline of Project ##
This is a repository implementing KNN (the first machine learning algorithms I learnt) to predict the classification of various things. 

First, the iris.txt was used. In this dataset, an Iris flower is either an Iris setosa or Iris virginica classified as +1 or -1 respectively. Which is the target attribute given in the fifth column of the dataset. The first four columns are attributes describing sepal length, sepal width, petal length, and petal width in cm. There were 100 samples which were split into 70-30 for the train and test set respectively. The algorithm correctly predicted the 30 test classifications.

ionosphere.txt contains data collected by a radar system in Goose Bay, Labrador. This system consists of a co-phased array of 16 high-frequency antennas with a total transmitted power on the order of 6.4 kilowatts. The last number in the line describes the classification: +1 radar returns are those showing evidence of some type of structure in the ionosphere; -1 returns are those that do not. The first 200 rows were used the training set and the remaining 265 rows were used as the test set.

USPS.txt contains normalized handwritten digits, automatically scanned from envelopes by the US Postal Service. USPSsubset.txt is its subset. The original scanned digits are binary and of different sizes and orientations however, the images have been deslanted and size normalized, resulting in 16 * 16 grayscale images. The datasets are in two seperate files with each row consisting of the 256 grayscale values for the pixels followed by the true label 0-9. The data set consisted of two parts, 7291 training observations and 2007 test observations merged into the file USPS.txt. My knn algorithm correctly outputed a 10 x 10 confusion matrix identical to the knn function in R (albeit at a much slower rate).

## Description of the file structure ##

The Data_In folder contains 3 files: the train data in train.CSV, the test data in test.CSV and a description of the attributes in data_description.text. The final column in train.CSV contains the target attribute: 'SalePrice' which is what was predicted on the test data using a Lasso model. The Data_Out folder contains output CSV files of the models with various parameters and Plots contains examples of some of the plots produced. Main.py is where the other four classes 
 * DataLoader within Class_Data_Loader.py
 * DataExploration within Class_Data_Exploration.py
 * DataPreprocessing within Class_Data_Preprocessing.py
 * DataModel within Class_Data_Model.py
 
 are called and executed. Class_Data_Loader loads the data into a Pandas dataframe. Class_Data_Exploration contains methods that produce plots such as scatter graphs, histograms and box and whisker diagrams. The purpose of this class is to deal with outliers and missing data. The method missing_data_ratio_and_bar_graph() is useful to see the percentage of missing values for each attribute which can be dealt with accordingly using the class DataPreprocessing. The class DataPreprocessing modifies both the test and train data using methods that fill in the missing values for both data sets. The data is then transformed using a Box Cox  transformation and normalised. The class DataModel can then be used to implement a method such as linear  regression or a Lasso to return the predicted value of the target for each test sample.
 
The code was written in such a way that it would be possible to make a quick model on any data in a CSV file by first loading it into a pandas dataframe, explore the data, preprocess the data and then feed it into a model that will produce an accurate outcome. This was done by using inheritance where DataModel -> DataPreprocessing -> DataExploration -> DataLoader and the arrow  is a symbol indicating 'inherited from'. 

This was done so that if one only wanted to only explore the data, only the functions within the class DataExploration DataLoader are available when an object is constructed using DataExploration. If a model is to be fitted then DataModel can be called to create an object where none of the data hasn't been tampered with If inheritance wasn't used then it would be more difficult to keep track of how the test and train data were modified. 

Full documentation of the methods within the classes will be added at a later date.

## Packages Required: ##
Environment set up in python 3.5 and runs with following packages:
* numpy        V:1.14.5
* pandas       V:0.23.4
* matplotlib   V:2.2.3
* scikit-learn V:0.19.2
<p>

## Examples ##
Examples of how to run the code will be added at a later date.
