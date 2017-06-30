#!/bin/bash

echo "Going to run weka classifiers"

DATA_LOCATION="/home/pranav/Project/arff_files"
WEKA_LIB="/home/pranav/Project/weka.jar"
DATA_RESULT_LOCATION="/home/pranav/Project/Result"

#java -cp $WEKA_LIB weka.classifiers.trees.J48 -t $DATA_LOCATION -x 10 > $DATA_RESULT_LOCATION/diabetes.csv

declare -a fileArray=("functions.Logistic" "functions.MultilayerPerceptron" "bayes.NaiveBayes" "lazy.IBk" "trees.J48" "trees.RandomForest")

declare -a array=("electricity-normalized" "pc4" "MagicTelescope" "irish" "pc1" "tic-tac-toe" "ionosphere" "diabetes")
arraylength=${#array[@]}

declare -a kval=("1" "3" "5" "9" "17" "33" "65" "129" "257" "513")

declare -a conf=("0.1" "0.2" "0.3" "0.4" "0.5" "0.6" "0.7" "0.8" "0.9" "1")

declare -a ridge=("0.00000001" "0.000001" "0.0001" "0.01" "1" "10" "100" "1000" "10000" "100000")

## KNN
echo "KNN"
for (( i=0; i<${arraylength}; i++ ));
do
  echo $i " / " ${arraylength} " : " ${array[$i]}
  
counter=0

 
while [ $counter -le 9 ]
do
#Task="-K $kval"

java -cp $WEKA_LIB weka.classifiers.lazy.IBk -K ${kval[counter]} -t $DATA_LOCATION/${array[$i]}.arff -x 10 > $DATA_RESULT_LOCATION/KNN/${array[$i]}FOR_KVAL${kval[counter]}.csv

echo "uniform - " " counter " $counter " : " ${array[$i]}

((counter++))
done

counter=0
while [ $counter -le 9 ]
do
#Task="-K $kval"

java -cp $WEKA_LIB weka.classifiers.lazy.IBk -K ${kval[counter]} -I -t $DATA_LOCATION/${array[$i]}.arff -x 10 > $DATA_RESULT_LOCATION/KNN/${array[$i]}INVERSE_FOR_KVAL${kval[counter]}.csv

echo "inverse - " " counter " $counter " : " ${array[$i]}

((counter++))
done

done


## C4.5
echo "c4.5"
for (( i=0; i<${arraylength}; i++ ));
do
  echo $i " / " ${arraylength} " : " ${array[$i]}

check=0  
while [ $check -le 9 ]
do

counter=0
while [ $counter -le 9 ]
do
#Task="-K $kval"

java -cp $WEKA_LIB weka.classifiers.trees.J48 -C ${conf[check]} -M ${kval[counter]} -t $DATA_LOCATION/${array[$i]}.arff -x 10 > $DATA_RESULT_LOCATION/C45/${array[$i]}CONF${conf[check]}KVAL${kval[counter]}.csv

echo "check "$check " counter " $counter " : " ${array[$i]}

((counter++))
done

((check++))
done

done


## Random Forest
echo "Random Forest"
for (( i=0; i<${arraylength}; i++ ));
do
  echo $i " / " ${arraylength} " : " ${array[$i]}

check=0  
while [ $check -le 9 ]
do

counter=0
while [ $counter -le 9 ]
do
#Task="-K $kval"

java -cp $WEKA_LIB weka.classifiers.trees.RandomForest -I ${kval[check]} -depth ${kval[counter]} -t $DATA_LOCATION/${array[$i]}.arff -x 10 > $DATA_RESULT_LOCATION/RandomForest/${array[$i]}NTREE${kval[check]}KVAL${kval[counter]}.csv

  echo "check "$check " counter " $counter " : " ${array[$i]}

((counter++))
done

((check++))
done

done


## Logistic
echo "Logistic Regression"
for (( i=0; i<${arraylength}; i++ ));
do
  echo $i " / " ${arraylength} " : " ${array[$i]}

check=0  
while [ $check -le 9 ]
do

counter=0
while [ $counter -le 9 ]
do
#Task="-K $kval"

java -cp $WEKA_LIB weka.classifiers.functions.Logistic -M ${kval[check]} -R ${ridge[counter]} -t $DATA_LOCATION/${array[$i]}.arff -x 10 > $DATA_RESULT_LOCATION/Logistic/${array[$i]}ITER${kval[check]}R${ridge[counter]}.csv

  echo "check "$check " counter " $counter " : " ${array[$i]}

((counter++))
done

((check++))
done

done


