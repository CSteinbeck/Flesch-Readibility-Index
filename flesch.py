##Colton Steinbeck##
##Flesch Readibility Index in Python





##Main Method##
if __name__== '__main__':
    print("Please enter specific file locations for translations: ")
    filename = input()
    BibleFile = open(filename, 'r')
    vals_list =[]
    for line in BibleFile.readlines():
        vals_list.append(line)
        print(vals_list[-1]) ##-1 pulls the last item in the list (array)

