CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
echo 'Finished cloning'

cd student-submission

if [[ -e ListExamples.java ]]
then
    echo "ListExamples found"
else
    exit "You must submit a file called 'ListExamples.java'"
fi

cd ../

cp TestListExamples.java student-submission/
cp -R lib/ student-submission/

cd student-submission

javac -cp ".;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar" *.java

if [[ $lc > 0 ]]
then
    exit "ListExamples.java failed to compile"
fi

echo "Compile Successful"

java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > run-output.txt
    
grep "testMergeRightEnd" run-output.txt > grep-results.txt
wc -l grep-results.txt > line-total.txt
lc=$(cat line-total.txt)

if [[ $lc > 0 ]]
then
    echo "Tester 'testMergeRightEnd' failed"
    exit "Failed to run successfully"
fi

echo "All tests passed"