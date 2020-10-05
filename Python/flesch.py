##Colton Steinbeck##
##Flesch Readibility Index in Python

def isVowel(char):

    if char == 'a' or char == 'e'or  char == 'i'or char == 'o' or char =='u' or char == 'y':
        return True
    else:
        return False

def isNumber(word):
    return word.isnumeric()

def syllableCount(word):
    index = 0
    syllable=0
    for i in range(0,len(word)):
        if(isVowel(i) and not(isVowel(i+1))):
            syllable =syllable + 1
    if(word.endswith('e')):
        syllable = syllable - 1
    if(syllable == 0):
        syllable = 1
    return syllable

##Main Method
if __name__== '__main__':
    print("Please enter specific file locations for translations: ")
    filename = input()
    BibleFile = open(filename, 'r')
    vals_list = []
    for line in BibleFile.readlines():
        vals_list.append(line)
         ##print(vals_list[-1]) ##-1 pulls the last item in the list (array)
    dcInput = open("/pub/pounds/CSC330/dalechall/wordlist1995.txt",'r')
    dcStorage=set()
    ##String Cleanup for diffword accuracy
    for line in dcInput.readlines():
        temp=""
        for char in line:
            if char.isalpha():
                temp += char.lower()
        dcStorage.add(temp)
   
##Instantiates Variables
wordcount= 0
syllables= 0
sentences= 0
diffWord= 0
i=0
j=0
##print("Test")

##Loop for cycling through the translation (MAIN LOOP)
for i in range(0, len(vals_list), 1):
    instance = vals_list[i]
    words = vals_list[i].split()
    prev= False
    curr = False
    
    for word in words:
        if(not isNumber(word)):
            tempsyllable =0
            wordcount = wordcount + 1

            ##Break it down on the Char level
            for char in word:
                if char == '.' or char == '?' or char == '!' or char == ':' or char == ";":
                    sentences = sentences + 1
                if(isVowel(char)): ##Checks using the vowel method
                    curr = True
                else:
                    curr = False
                if(curr and not(prev)): #If the current char is true and the previous char is falase
                    tempsyllable = tempsyllable +1
                prev = curr
            if(len(word) > 1): ##If the length of word is greater that one
                if(word[len(word)-1] == 'e' and not isVowel(word[len(word)-2])): ##2nd Case: 'e' 
                    
                    tempsyllable = tempsyllable - 1
            if(tempsyllable == 0): ##3rd Case: End of Word w/ no syllable detected
                tempsyllable = tempsyllable + 1  
            syllables+=tempsyllable              
        #print("PAIN") ##Lol, this is a debug statement
            if not(word in dcStorage):
                diffWord = diffWord + 1
print("Word Count: ", wordcount)
print("Syllable Count: ", syllables)
print("Sentence Count: ", sentences)
print("Difficult Words: ", diffWord)

##Numeric Calculations
alpha = syllables/wordcount
beta = wordcount/sentences
gamma = diffWord/wordcount

flesch =  206.835 - (alpha * 84.6) - (beta * 1.015)
grade = (alpha * 11.8) + (beta * 0.39) - 15.59
if gamma > 0.05:
    readability = ((gamma * 100.0) * 0.1579) + (beta * 0.0496) + 3.6365
else:
    readability = ((gamma * 100.0) * 0.1579) + (beta * 0.0496)

##Final Scores Printout
print("The Flesch Readability index is: " , flesch)
print("The Flesh-Kincaid Grade Level index is: ", grade)
print("The Dale-Chall Readability Score is: ", readability)
