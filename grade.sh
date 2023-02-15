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

if [[ $? -ne 0 ]]
then
    exit "Compile failed"
fi

echo "Compile Successful"

java -cp ".;lib/junit-4.13.2.jar;lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples
    