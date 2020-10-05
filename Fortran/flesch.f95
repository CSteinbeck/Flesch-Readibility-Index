!!Colton Steinbeck
!!Flesch Readibility in Fortran
program flesch
!!Defines Global variables
character(:), allocatable :: long_string, word, dcstring
integer:: filesize,i,j,sentences,syllables,wordcount,dcfilesize,diffWord
real :: alpha, beta,gamma, grade, index, readability


!!Calling subroutines (functions)
interface
subroutine read_file( string, filesize )
character(:), allocatable :: string
integer :: filesize
end subroutine read_file

subroutine SentenceCheck(string, sentence)
character(:), allocatable :: string
integer :: sentence, index
end subroutine

subroutine SyllableCount( word, syllable)
    character(:), allocatable :: word
    integer :: syllable, index
    logical:: prev, current

    end subroutine

subroutine dcreader( string, filesize )
    character(:), allocatable :: string
    integer :: filesize
    end subroutine dcreader

    logical function dcWordCheck( string1, string2 ) result( out )
    character(:), allocatable :: string1, string2
    end function dcWordCheck    

end interface

call read_file( long_string, filesize )
call dcreader(dcstring, dcfilesize)


!!Faster Tokenizing Loop
sentences=0
wordcount=0
syllables=0
diffWord=0
i=1
j=1
k=1
do while(j .ne. filesize + 1 )
    
    if(long_string(j:j) .eq. " ") then !!!if the long_string(j) equals a space
        
        allocate(character(j-i):: word) !!Allocate space in memory for a word
        wordcount=wordcount + 1 !!Increment word count
        
        word=long_string(i:j) !!Define the word as a string between i and j
    
       !!Checks functions for syllable and sentence!!
       call SentenceCheck(word,sentences)
       call SyllableCount(word,syllables)
       if( .not. dcWordCheck(dcstring,word))then !!If the word is in the DC wordlist
        diffWord = diffWord + 1
       endif
       
       !Should be at the end of the main method
       deallocate(word) !!Deallocates the memory for that specific word
        i=j !!Resets value
    
    endif
    j = j + 1 !!increments j until long_string is completed
    
enddo


!!!Printing Results!!!!
print*, " Here are the number of sentences:", sentences
print*, " Here are the number of words:", wordcount
print*, " Here are the number of syllables:", syllables
print*, " Here are the number of difficult words:", diffWord

alpha = real(syllables) / real(wordcount)
beta = real(wordcount) / real(sentences)
gamma = real(diffWord) / real(wordcount)

index = 206.835 - (alpha * 84.6) - (beta * 1.015)
grade = (alpha * 11.8) + (beta * 0.39) - 15.59
if(gamma .gt. 0.05) then
    readability = ((gamma * 100.0) * 0.1579) + (beta * 0.0496) + 3.6365
else
    readability = ((gamma * 100.0) * 0.1579) + (beta * 0.0496)
endif
print *, "The Flesch Readability Index is: ", index
print *, "The Flesh-Kincaid Grade Level is: ", grade
print *, "The Dale-Chall Grade Readibility is: ",readability
end program flesch

!!!!!!Defining Subroutines!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

subroutine read_file(string, filesize)
    character(:), allocatable       :: string
    character(50)                   :: filename
    integer                         :: counter
    integer                         :: filesize

    character(LEN=1)                :: input
    !!Calls Users input on the command line while running the code
    call get_command_argument(1, filename)
    inquire(file=filename, size=filesize)
    open(unit=5,status="old",access="direct",form="unformatted",recl=1,file=filename)
    allocate(character(filesize)    :: string)

    counter = 1
    100 read (5, rec = counter, err = 200) input
    string(counter:counter) = input
    counter = counter + 1
    goto 100

    200 continue

    counter = counter - 1
    close(5)
end subroutine read_file

    !!Reader for the dc text file
    subroutine dcreader( string, filesize )
        character(:), allocatable :: string
        integer :: counter
        integer :: filesize
        character (LEN=1) :: input
        
        inquire (file="/pub/pounds/CSC330/dalechall/wordlist1995.txt", size=filesize)
        open (unit=5,status="old",access="direct",form="unformatted",recl=1,&
        file= "/pub/pounds/CSC330/dalechall/wordlist1995.txt")
        allocate( character(filesize) :: string)
        
        counter=1
        100 read (5,rec=counter,err=200) input
            string(counter:counter) = input
            counter=counter+1
            goto 100
        200 continue
        counter=counter-1
        close (5)
        end subroutine dcreader

        !!
        logical function dcWordCheck ( string1, string2 ) result(out)
        character(:), allocatable :: string1, string2
        out = .false.   
        if ( index(trim(adjustl(string1)), trim(adjustl(string2))) .ne. 0 ) then !!If the two words aren't the same
        out = .true.
        endif
        end function dcWordCheck


    subroutine SentenceCheck(string, sentence)
    character(:), allocatable :: string
    integer :: sentence, index
        index= 1
        do while (index .le. len(string)) !!While the index is less than the length of the string
        !!Puncuation Check
        if(string(index:index) .eq. '.' .or. string(index:index) .eq. '?'.or. string(index:index) .eq. '!'&
        .or. string(index:index) .eq. ':' .or. string(index:index) .eq. ';' ) then
           sentence= sentence +1
        endif
        index =index +1
    enddo
        end subroutine

        subroutine SyllableCount( word, syllable)
            character(:), allocatable :: word
            integer :: syllable, index
            logical :: prev, current !If the previous and current chars are vowels

            prev =.false. !!Previous Char
            current= .false. !!Current Char
            index=1
        do while(index .le. len(word)) !!While the index is less than the length of the word
            !!Vowel Check
            if(word(index:index) .eq. 'a'.or. word(index:index) .eq. 'A' .or. word(index:index) .eq. 'e' &
            .or. word(index:index) .eq. 'E' .or. word(index:index) .eq. 'i'.or. word(index:index) .eq. 'I' &
            .or. word(index:index) .eq. 'o'.or. word(index:index) .eq. 'O'&  
            .or. word(index:index) .eq. 'u'.or. word(index:index) .eq. 'U' &
            .or. word(index:index) .eq. 'y'.or. word(index:index) .eq. 'Y') then
                current=.true.
            else
                current =.false.
          endif
          if( .not. prev .and. current ) then !!If previous char is false and current is true
          syllable = syllable + 1
          endif
          !!2nd Case: 'e' case and last letter of the word
          if(word(index:index) .eq. 'e' .and. index .eq. len(word) .and. .not. prev) then
            syllable = syllable - 1
          endif
          !!Resets so the Previous is now the current and increments
          prev = current
          index= index + 1
        enddo
        
            end subroutine SyllableCount
