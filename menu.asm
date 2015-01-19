#Joshua Bridge - 14032908, Options 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 implemented

.data
menu:   		.ascii "\n"	
			.ascii "\nMENU - Joshua Bridge, 14032908\n"
			.ascii "1, Enter Number 1\n"
			.ascii "2, Enter Number 2\n"
			.ascii "3, Display num1 and num2\n"
			.ascii "4, Display sum of num1 and num2\n"
			.ascii "5, Display product of num1 and num2\n"
			.ascii "6, Divide num1 by num2\n"
			.ascii "7, Exchange numbers 1 and 2\n"
			.ascii "8, Display Numbers between num 1 and num 2\n"
			.ascii "9, Sum numbers between num1 and num2\n"
			.ascii "10, Raise num 1 to the power of num2\n"
			.ascii "11, Display prime numbers between num1 and num2\n"
			.ascii "12, Quit\n"
			.ascii "\n"
			.ascii "Please enter menu option: "
			.asciiz ""
			
str.nl:			.asciiz "\n"	#new line
str.cnl:		.asciiz ":\n"	#colon new line
str.num1:		.asciiz "Enter Num1: "
str.num2:		.asciiz "Enter Num2: "
str.numprint1:		.asciiz "\nNumber 1 is: "
str.numprint2:		.asciiz "\nNumber 2 is: "
str.eq:			.asciiz " = "
str.addresult:		.asciiz " + "
str.mulresult:		.asciiz " * "
str.powerresult:	.asciiz " ^ "
str.divresult1:		.asciiz " ÷ "
str.divresult2:		.asciiz " Remainder: "
str.divresult3:		.asciiz " Floating Point: "
str.swapnum:		.asciiz "\nSwapped Numbers!"
str.betweennum:		.asciiz "\nNumbers between and including "
str.sumcount:		.asciiz "\nSum of numbers between and including "
str.powerstring:	.asciiz "\nNum1 to the power of Num2:\n\n"
str.power0:		.asciiz "\n\nAnything to the power of 0 is 1!"
str.primenum:		.asciiz "\nPrime numbers between and including "
str.negnum:		.asciiz "\nAvoid negative numbers - By usual definition there are no negative primes! :(\n"
str.negnumreset:	.asciiz "\nPlease enter at least one positive number above 1!\n"
str.intendloop:		.asciiz "\nResult was above int limit! :(\n"
	
.text
printMenu: 
	#print MENU text						
	addi $v0, $zero, 4						#load service address 4 (string print address $a0)
	la $a0, menu							#load string address
	syscall								#print the MENU! 
	#read user input						
	addi $v0, $zero, 5						#load service address 5 (user input int into $v0)
	syscall								#wait for user input
	add $s3,$zero, $v0						#move user's choice into $s3
	#process MENU choice							
	beq $s3,1,opt1							
	beq $s3,2 opt2							
	beq $s3,3,opt3							
	beq $s3,4,opt4							
	beq $s3,5,opt5							
	beq $s3,6,opt6							
	beq $s3,7,opt7							
	beq $s3,8,opt8							
	beq $s3,9,opt9							
	beq $s3,10,opt10						
	beq $s3,11,opt11						
	beq $s3,12,quit							
	#reset if invalid input						
	j printMenu							#user selected an invalid option so print menu again (>printMenu)
				
									
#these are a list of callable functions via the JALR (jump and link register) command																			
dispnum1:								
	#print Num1							
	addi $v0, $zero, 1						#load service address 1 (int print $a0)
	add $a0, $zero, $s0						#insert Num1 into $a0
	syscall 							#print Num1
	#return to sender address					
	jr $k0 								
									
dispnum2:								
	#print Num2							
	addi $v0, $zero, 1						#load service address 1 (int print $a0)
	add $a0, $zero, $s1						#insert Num2 into $a0
	syscall 							#print Num2
	#return to sender address					
	jr $k0 								
									
printspace:								
	#print ' '							
	addi $v0, $zero, 11						#load service address 11 (char print $a0)
	addi $a0, $zero, ' '						#put char ' ' into $a0
	syscall 							#print ' '
	#return to sender address					
	jr $k0 								
	
printstringend: # print num1 + " & " + num2 + ":\n"
	#print Num1							
	addi $v0, $zero, 1						#load service address 1 (int print $a0)
	add $a0, $zero, $s0						#insert Num1 into $a0
	syscall 							#print Num1
	#print ' '							
	addi $v0, $zero, 11						#load service address 11 (char print $a0)
	addi $a0, $zero, ' '						#put char ' ' into $a0
	syscall 							#print ' '								
	#print '&'							
	addi $v0, $zero, 11						#load service address 11 (char print $a0)
	addi $a0, $zero, '&'						#put char '&' into $a0
	syscall 							#print '&'
	#print ' '							
	addi $v0, $zero, 11						#load service address 11 (char print $a0)
	addi $a0, $zero, ' '						#put char ' ' into $a0
	syscall 							#print ' '
	#print Num2							
	addi $v0, $zero, 1						#load service address 1 (int print $a0)
	add $a0, $zero, $s1						#insert Num2 into $a0
	syscall 							#print Num2
	#print ":\n"		
	addi $v0, $zero, 4						#load service address 4 (string print address $a0)
	la $a0, str.cnl							#load string address (colon-new-line)
	syscall								#print ":\n"
	#return to sender address					
	jr $k0 						
	
opt1: #Enter Num1							
	#print "Enter Num2: "						
	addi $v0, $zero, 4						#load service address 4 (string print address $a0)
	la $a0, str.num1						#load string address
	syscall								#print "Enter Num1: "
	#input Num2 and store						
	addi $v0, $zero, 5						#load service address 5 (user input int into $v0)
	syscall								#wait for input
	add $s0, $zero, $v0 						#set Num1($s0) to user input($v0)
	#return to MENU							
	j printMenu 							
									
opt2: #Enter Num2							
	#print "Enter Num2: "						
	addi $v0, $zero, 4						#load service address 4 (string print address $a0)
	la $a0, str.num2						#load string address
	syscall								#print "Enter Num2: "
	#input Num2 and store						
	addi $v0, $zero, 5 						#load service address 5 (user input int into $v0)
	syscall								#wait for input
	add $s1, $zero, $v0 						#set Num2($s1) to user input($v0)
	#return to MENU							
	j printMenu							
									
opt3: #Echo Num1 & Num2							
	#print "Number 1 is: "						
	addi $v0, $zero, 4						#load service address 4 (string print address $a0)
	la $a0, str.numprint1						#load string address
	syscall 							#print num1 message "Number 1 is: "
	#print Num1							
	la $k1, dispnum1 						#load printnum address
	jalr $k0, $k1 							#jump to dispnum1 then return
	#print "Number 2 is: "						
	addi $v0, $zero, 4						#load service address 4 (string print address $a0)
	la $a0, str.numprint2						#load string address
	syscall 							#print num2 message "Number 2 is: "
	#print Num2							
	la $k1, dispnum2 						#load printnum address
	jalr $k0, $k1 							#jump to dispnum2 then return
	#return to MENU							
	j printMenu							
									
opt4: #Add Num1+Num2 and display										
	#print Num1							
	la $k1, dispnum1 						#load dispnum1 address
	jalr $k0, $k1 							#jump to dispnum1 then return
	#print " + "
	addi $v0, $zero, 4						#load service address 4 (string print address $a0)
	la $a0, str.addresult						#load string address
	syscall								#print " + "
	#print Num2							
	la $k1, dispnum2						#load dispnum2 address
	jalr $k0, $k1 							#jump to dispnum2 then return
	#print " = "
	addi $v0, $zero, 4						#load service address 4 (string print address $a0)
	la $a0, str.eq							#load string address
	syscall								#print " = "
	#print Num1 + Num2 result					
	addi $v0, $zero, 1						#load service address 1 (int print $a0)
	add $a0, $s0, $s1						#Num1+Num2
	syscall								#print result $a0
	#return to MENU							
	j printMenu							
									
opt5: #Multiply Num1*Num2 and display					
	#print Num1							
	la $k1, dispnum1 						#load dispnum1 address
	jalr $k0, $k1 							#jump to dispnum1 then return
	#print " * "
	addi $v0, $zero, 4						#load service address 4 (string print address $a0)
	la $a0, str.mulresult						#load string address
	syscall								#print " * "
	#print Num2							
	la $k1, dispnum2						#load dispnum2 address
	jalr $k0, $k1 							#jump to dispnum2 then return
	#print " = "
	addi $v0, $zero, 4						#load service address 4 (string print address $a0)
	la $a0, str.eq							#load string address
	syscall								#print " = "
	#print Num1 * Num2 result					
	addi $v0, $zero, 1						#load service address 1 (int print $a0)
	mul $a0, $s0, $s1						#Num1*Num2
	syscall								#print result $a0
	#return to MENU							
	j printMenu							
									
opt6: #Divide num1/num2 and display					
	#print Num1							
	la $k1, dispnum1 						#load dispnum1 address
	jalr $k0, $k1 							#jump to dispnum1 then return
	#print " ÷ "
	addi $v0, $zero, 4						#load service address 4 (string print address $a0)
	la $a0, str.divresult1						#load string address
	syscall								#print pre-divnum string " ÷ "	
	#print Num2							
	la $k1, dispnum2						#load dispnum2 address
	jalr $k0, $k1 							#jump to dispnum2 then return
	#print " = "
	addi $v0, $zero, 4						#load service address 4 (string print address $a0)
	la $a0, str.eq							#load string address
	syscall								#print " = "
	#print Num1÷Num2 Quotient	
	addi $v0, $zero, 1						#load service address 1 (int print $a0)
	div $s0, $s1							#Num1÷Num2
	mflo $a0 							#move quotient into $a0
	syscall								#print quotient $a0
	#print "Remainder: "						
	addi $v0, $zero, 4						#load service address 4 (string print address $a0)
	la $a0, str.divresult2						#load string address
	syscall								#print mid-divnum string "Remainder:"
	#print Remainder of Num1÷Num2					
	addi $v0, $zero, 1						#load service address 1 (int print $a0)
	mfhi $a0 							#move remainder into $a0
	syscall								#print remainder $a0
	
	#NOW LET'S DO SOME FLOATING POINT DIVISION!
	#print "Floating Point: "						
	addi $v0, $zero, 4						#load service address 4 (string print address $a0)
	la $a0, str.divresult3						#load string address
	syscall								#print mid-divnum string "Floating Point: "
	#convert Num1 into single prec. float and store floatNum1($f0)
	mtc1 $s0, $f0							#move to coproc1 in $f0
	cvt.s.w $f0, $f0						#convert word to single precision float
	#convert Num2 into single prec. float and store floatNum2($f1)
	mtc1 $s1, $f1							#move to coproc1 in $f1
	cvt.s.w $f1, $f1						#convert word to single precision float
	#do division and print result
	addi $v0, $zero, 2						#load service address 2 (single float print $f12)
	div.s $f12, $f0, $f1						#floatNum1($f0) ÷ floatNum2($f1)
	syscall								#print single precision float result $f12
	
	#return to MENU							
	j printMenu							
									
opt7: #Swap Num1 & Num2 and display					
	#print "Swapped Numbers!"					
	addi $v0, $zero, 4						#load service address 4 (string print address $a0)
	la $a0, str.swapnum						#load string address
	syscall								#print pre-swapnum string "Swapped Numbers!"
	#swap Num1 & Num2						
	add $s2, $zero, $s0 						#store num1 elsewhere temporarily
	add $s0, $zero, $s1 						#put num2 in num1 slot
	add $s1, $zero, $s2 						#put num1 in num2 slot
	
	addi $s3, $zero, 0						#reset temp value
	#print new Num1 & Num2 and return to MENU			
	j opt3 								#jump back to display the numbers again (>opt3) and return to MENU (<printMenu)
									
opt8: #Display Numbers between and including num 1 and num 2		
	#make tempNum1($t0) value					
	add $t0, $0, $s0 						#store num1 in seperate editable value tempNum1($t0) 
	#print "Numbers between and including "		
	addi $v0, $zero, 4						#load service address 4 (string print address $a0)
	la $a0, str.betweennum						#load string address
	syscall								#print pre-betweennum string "Numbers between and including Num1 & Num2:"
	#print num1 + " & " + num2 + ":\n"				
	la $k1, printstringend						#print string end (load printstringend address)
	jalr $k0, $k1 							#print num1 + " & " + num2 + ":" (>printstringend) then return (<opt8.1)
	#find and mark count direction						
	opt8.1: 							#if Num1 > Num2	
		bgt $t0, $s1, opt8.3 						#if Num1 > Num2 jump to countDown (>opt8.3)
	opt8.2: 							#if Num1 < Num2 set countFlag($t1) to up and goto loop (>opt8.4)
		addi $t1, $0, 1 						#1 = count upwards flag
		j opt8.4							#jump to loop
	opt8.3: 							#if Num1 > Num2 set countFlag($t1) to down	
		addi $t1, $0, 0 						#0 = count downwards flag
									
	#loop from Num1 to Num2						
	opt8.4: 							#loop code
		#print current tempNum1($t0) value					
		add $a0, $zero, $t0 						#put value tempNum1($t0) into $a0
		addi $v0, $zero, 1						#int print $a0 address 1
		syscall 							#print current tempNum1($t0) value
		#test if reached loop end				
		beq $t0, $s1, opt8.6 						#if reached end, jump to endloop code (>opt8.6)
		#print " + " if summing (opt9)					
		beq $t2, 1, opt9.1						#if sumFlag($t2)=1, jump to print " + " (>opt9.1) and return to (<opt8.4.1)						
		#if not summing just print space			
		la $k1, printspace 						#load printspace address
		jalr $k0, $k1 							#jump to printspace then return
		#tempNum1($t0) ± 1 depending on count direction		
		opt8.4.1:						
			beqz $t1, opt8.4.2 						#if countFlag($t1)=0(down) then jump to subtract1 (>opt8.4.2) and return to (<opt8.4.3)
			addi $t0, $t0, 1 						#else add one (tempNum1($t0)++)					
			j opt8.4.3
		
		opt8.4.2:								
			#tempNum1($t0)--					
			subi $t0, $t0, 1 						#subtract one
		
		opt8.4.3:						
			#loop back || sumTotal($t3)+tempNum1($t0) (>opt9.2)...	
			#	...then loop back (<opt8.4)		
			beqz $t2, opt8.4						#if no sum flag then loop back
			j opt9.2							#else goto sumTotal($t3) + tempNum1($t0) (>opt9.2) then loop back (<opt8.4)
									
	opt8.6: 							#endloop
		#reset used values and return to MENU			
		addi $t1, $0, 0 						#reset countFlag($t1)
		addi $t0, $0, 0 						#reset tempNum1($t0) just incase
		beqz $t2, printMenu 						#if no sum flag then return to MENU (>printMenu)
		j opt9.3							#else goto print sumTotal($t3) & reset sum values (>opt9.3) then return to MENU (<printMenu)
									
opt9: #Sum numbers between num1 and num2				
	#create sumFlag($t2)=1, tempNum1($t0)=Num1($s0), sumTotal($t3)=tempNum1($t0)				
	addi $t2, $0, 1							#flag for adding each number in 8.3 loop (sumFlag($t2)=1)
	add $t0, $0, $s0 						#store num1 in seperate editable value tempNum1($t0)
	add $t3, $0, $t0 						#create sumTotal($t3) register starting from tempNum1($t0)
	#print "Sum of numbers between and including Num1 & Num2:"	
	addi $v0, $zero, 4						#load service address 4 (string print address $a0)
	la $a0, str.sumcount						#load string address
	syscall								#print pre-sumcount string "Sum of numbers between and including Num1 & Num2:"
	#print num1 + " & " + num2 + ":"					
	la $k1, printstringend						#print string end (load printstringend address)
	jalr $k0, $k1 							#print space (jump to printstringend then return)
	#enter opt8 loop with sumFlag($t2)=1				
	j opt8.1							
									
	#from here on just provides functions for the loop to jump to when sumFlag($t2) is 1	
	opt9.1: 							#print " + " between numbers
		#print " + "
		addi $v0, $zero, 4						#load service address 4 (string print address $a0)
		la $a0, str.addresult						#load string address (same as opt4 string)
		syscall								#print " + "
		#back to loop code					
		j opt8.4.1						
									
	opt9.2: 							#add number to sumtotal
		#sumTotal($t3) + tempNum1($t0)
		add $t3, $t3, $t0 						#add current val to sumTotal($t3)
		j opt8.4							#return to loop beginning
									
	opt9.3: 							#print sumtotal & reset values
		#print " = "
		addi $v0, $zero, 4						#load service address 4 (string print address $a0)
		la $a0, str.eq							#load string address
		syscall								#print " = "
		#print final sumTotal($t3)					
		addi $v0, $zero, 1						#load service address 1 (int print $a0)
		add $a0, $zero, $t3 						#put value sumTotal($t3) into $a0
		syscall 							#print value sumTotal($t3)
		#reset sum values					
		addi $t3, $0, 0 						#reset sumTotal($t3) just incase
		addi $t2, $0, 0 						#reset sumFlag($t2)
										
		j printMenu						
									
opt10: #Raise num 1 to the power of num2	
	#create temp values			
	add $t0, $0, $s0 						#store num1 in seperate editable value tempNum1($t0)
	add $t2, $0, $s1 						#store num2 in seperate editable value tempNum2($t2)
	addi $t4, $0, 1							#Create LoopCount($t4) and start from 1
	
		#print "Num1 to the power of Num2:" + Num1 + " ^ " + Num2 + " = " (e.g. 10 ^ -2 = ANS)
		opt10.0.1:
			#print "Num1 to the power of Num2:"
			addi $v0, $zero, 4						#load service address 4 (string print address $a0)
			la $a0, str.powerstring							#load string address
			syscall								#print " = "	
			#print Num1							
			addi $v0, $zero, 1						#load service address 1 (int print $a0)
			add $a0, $zero, $s0						#insert Num1 into $a0
			syscall 							#print Num1
			#print " ^ "
			addi $v0, $zero, 4						#load service address 4 (string print address $a0)
			la $a0, str.powerresult							#load string address
			syscall								#print " ^ "								
			#print Num2							
			addi $v0, $zero, 1						#load service address 1 (int print $a0)
			add $a0, $zero, $s1						#insert Num2 into $a0
			syscall 							#print Num2
			#print " = "
			addi $v0, $zero, 4						#load service address 4 (string print address $a0)
			la $a0, str.eq							#load string address
			syscall								#print " = "					
		
	opt10.1: #error handling (power of 0 or -x or Num1 == 0)
		#if Num1 == 0 then print 0 and return to MENU
		beqz $t0, opt10.1.3
		#if power of 0 (>opt10.1.1) make ANS 1
		beqz $t2, opt10.1.1
		#if power of negative (>opt10.1.2) 1 ÷ ANS (in floating point)
		bltz $t2, opt10.1.2
		#else continue
		j opt10.2
		
		#make output just '1' if ^0
		opt10.1.1:
			#print 1
			addi $v0, $zero, 1						#load service address 1 (int print $a0)
			addi $a0, $zero, 1						#insert 1 into $a0
			syscall 							#print 1
			#print power of 0 message
			addi $v0, $zero, 4						#load service address 4 (string print address $a0)
			la $a0, str.power0						#load string address
			syscall								#print
			#reset used variables and return to MENU (>printMenu)
			j opt10.6
			
		#if negative power
		opt10.1.2:
			#make negative tempNum2($t2) positive
			sub $t2, $0, $t2						#subtract tempNum2($t2) from 0 (e.g. 0 - -4 == 4)
			#present answer of positive power tempNum2($t2) as 1 ÷ ANS
			addi $t1, $0, 1							#make negPower($t1) flag
			
			j opt10.2
			
		opt10.1.3:
			#print 0
			addi $v0, $zero, 1						#load service address 1 (int print $a0)
			addi $a0, $zero, 0						#insert 0 into $a0
			syscall 							#print 0

			#reset used variables and return to MENU (>printMenu)
			j opt10.6
			
	#loop until loopCount($t4) == num2($s1)
	opt10.2:
		#if end of loop, quit
		beq $t4, $t2, opt10.3						#if end of loop (loopCount($t4) == num2($s1)) then jump to endLoop(>opt10.3)
		#if tempNum1($t0) is 0 (if past int limit) then end loop
		beqz $t0, opt10.4						#if int limit hit (tempNum1($t0) == 0) then jump to intEndLoop(>opt10.4)
		#bring the power
		mul $t0, $t0, $s0						#tempNum1($t0) * num1($s0)
		#loopCount($t4)++				
		addi $t4, $t4, 1				
		#loop back (>opt10.2)	
		j opt10.2	
	
	opt10.3:
		#if negPower($t1) == 1, skip to negPower exit (>opt10.5)
		beq $t1, 1, opt10.5
		#else print the result
		addi $v0, $zero, 1						#load service address 1 (int print $a0)
		add $a0, $zero, $t0						#insert tempNum1 into $a0
		syscall 							#print tempNum1
		#reset used variables
		j opt10.6
		
	opt10.4: 							#intEndloop
		#if past int limit (number becomes 0) print warning and return to MENU
		addi $v0, $zero, 4						#load service address 4 (string print address $a0)
		la $a0, str.intendloop						#load string address
		syscall	
		j printMenu
	
	#if negative power do 1 ÷ ANS in floating point
	opt10.5:
		#FLOATING POINT DIVISION PART 2
		addi $k0, $0, 1							#have value of 1 for division of 1
		#convert 1 into single prec. float and store floatNum1($f0)
		mtc1 $k0, $f0							#move 1 to coproc1 in $f0
		cvt.s.w $f0, $f0						#convert word to single float
		#convert result into single prec. float and store floatNum2($f1)
		mtc1 $t0, $f1							#move tempNum1($t0) to coproc1 in $f1
		cvt.s.w $f1, $f1						#convert word to single precision float
		#do division and print result
		addi $v0, $zero, 2						#load service address 1 (int print $a0)
		div.s $f12, $f0, $f1						#floatNum1($f0) ÷ floatNum2($f1)
		syscall								#print single precision float result $f12
		
		addi $k0, $0, 0							#reset used 1 value
		#reset used variables and return to MENU (>printMenu)
		
	opt10.6:
		#reset used variables
		addi $t0, $0, 0 						#reset tempNum1($t0)
		addi $t2, $0, 0 						#reset tempNum2($t2)
		addi $t4, $0, 0 						#reset loopCount($t4)
		j printMenu		
										
opt11: #Display prime numbers between num1 and num2			
	#create temp values						
	add $t0, $0, $s0 						#store num1 in seperate editable value tempNum1($t0)
	add $t2, $0, $s1 						#store num2 in seperate editable value tempNum2($t2)
	#find count direction						
	bgt $t0, $t2, opt11.1.2 					#if Num1 > Num2 (>opt11.1.2) else (>opt11.1.1)
	#set countFlag							
	opt11.1:							
		opt11.1.1: 							#if countup (Num1 < Num2)
			#set countFlag($t1) = 1(up)			
			addi $t1, $0, 1 						#countFlag($t1) = 1(up)
			#start error-checking
			j opt11.1.3
			
		opt11.1.2: 							#if countdown (Num1 > Num2)
			#set countFlag($t1) = 0(down)		
			addi $t1, $0, 0 						#countFlag($t1) = 0(down)
			#start error-checking
		
		#error checking (one or both nums above 1 etc)
		opt11.1.3:							#error checking
			#check Num1 is above 1
			bltz $t0, opt11.2.1 						#error handling - if Num1 < 0 (>opt11.2.1)
			ble $t0, 1, opt11.2.3 						#error handling - if Num1 <= 1 (>opt11.2.3)
			#check Num2 is above 2 if Num1 > 1
			bltz $t2, opt11.2.2 						#error handling - if Num2 < 0 (>opt11.2.2)
			ble $t2, 1, opt11.2.4 						#error handling - if Num2 <= 1 (>opt11.2.4)	
							
		opt11.1.4: 							#print prime number pre-string
			#print "Prime numbers between Num1 & Num2:"	
			addi $v0, $zero, 4						#load service address 4 (string print address $a0)
			la $a0, str.primenum						#load string address
			syscall								#print "Prime numbers between Num1 & Num2:"
			#print num1 + " & " + num2 + ":\n"					
			la $k1, printstringend						#print string end (load printstringend address)
			jalr $k0, $k1 							#print space (jump to printstringend then return)
			#start outerloop				
			j opt11.3											
			
	opt11.2: 							#error handling
		#error handling - if Num1 < 0
		opt11.2.1: 							
			#exit if Num1 < 0 && Num2 <= 1			
			ble $t2, 1, opt11.2.10 						#if (Num1 < 0 && Num2 <= 1) jump to print negnumreset (>opt11.2.10)...
											#	...and return to MENU (<printMenu)  else >
			#print "Avoid negative numbers! :("		
			addi $v0, $zero, 4						#load service address 4 (string print address $a0)
			la $a0, str.negnum						#load string address
			syscall								#print "Avoid negative numbers! :("					
			#make num1 = 2
			j opt11.2.5			
		#error handling - if Num2 < 0 (&& Num1 >= 2)
		opt11.2.2: 							
			#print "Avoid negative numbers! :("		
			addi $v0, $zero, 4						#load service address 4 (string print address $a0)
			la $a0, str.negnum						#load string address
			syscall								#print "Avoid negative numbers! :("
			#make num2 = 2
			j opt11.2.4					
		#error handling - if Num1 <= 1
		opt11.2.3: 							
			#exit if Num1 && Num2 <= 1
			ble $t2, 1, opt11.2.10 						#error handling - if Num2 <= 1 then exit (>opt11.2.10)
			#make num1 = 2
			j opt11.2.5
		#error handling - if Num2 <= 1 (&& Num1 >= 2)
		opt11.2.4: 							
			#start/end outerloop at 2 (when only Num2 is below 2)			
			addi $t2, $0, 2							#set tempNum2($t2) to 2
			#print pre-primenum srting and start outerloop	
			j opt11.1.4
		#error handling - make num1 =2 if num2 >= 2
		opt11.2.5:
			#start/end outerloop at 2 (when only Num1 is below 2)
			addi $t0, $0, 2							#set tempNum1($t0) to 2
			#print pre-primenum srting and start outerloop	
			j opt11.1.4
		#error handling - reset if Num1 && Num2 <= 0
		opt11.2.10: 							
			#print "Please enter at least one positive[...	
			#	...] number above 1!"			
			addi $v0, $zero, 4						#load service address 4 (string print address $a0)
			la $a0, str.negnumreset						#load string address
			syscall								#print "Please enter at least one positive number above 1!"
			#return to MENU					
			j opt11.5 							#jump to endloop to reset values (>opt11.5) and return to MENU (<printMenu)
	#OUTERLOOP code	
	#outerloop loops from Num1 to Num2, subloop loops from 2 to current (tempNum1÷2), if no numbers divisible then current tempNum1($t0) is prime
															
	opt11.3: 							
		#find start and end positions for next subloop - only go from 2 to current tempNum1 ÷ 2, only need to...	
		#	...go halfway through each tempNum1 in subloop to find divisible numbers e.g. if tempNum1==10 then ÷5 would be the last divisible num
		addi $t4, $0, 2							#reset subLoopCount($t4) to 2
		div  $t0, $t4 							#divide tempNum1($t0) by 2 (using subLoopCount($t4)==2 number to reduce memory usage)
		mflo $t5 							#store result in subLoopEndNum($t5)
		addi $t5, $t5, 1						#add 1 to subLoopEndNum($t5) so it completes the subloop test for final value Num2 before quitting
		
		#SUBLOOP test for divisible numbers within current tempNum1($t0)			
		opt11.3.1: 							#subloop from subLoopCount($t4)==2 to subLoopEndNum($t5)==(tempNum1($t0) / 2)+1 
			#test for end of subloop conditions (if this...	
			#	...triggered then tempNum1($t0) is prime!)
			beq $t4, $t5, opt11.3.2						#if end of loop ($t4 == $t5) then print current tempNum1($t4) (>opt11.3.2) 
											#	& contintue outerloop (>opt11.3.2)
			#divide current tempNum1($t0) by current subLoopCount($t4)		
			div $t0, $t4							#tempNum1($t0) ÷ subLoopCount($t4)
			mfhi $t6							#store result in divResult($t6)
			#subLoopCount($t4)++				
			addi $t4, $t4, 1				
			#if not prime exit subloop			
			beqz $t6, opt11.3.3						#if mfhi = 0 (number is divisible) exit subloop without...
											#	 ...printing tempNum1($t4) (>opt11.3.3), else >
			#else loop back to subloop (>opt11.3.1)		
			j opt11.3.1						
									
		opt11.3.2:							#print found prime number
			#print current tempNum1($t0)			
			add $a0, $zero, $t0 						#print number (put value tempNum1($t0) into $a0)
			addi $v0, $zero, 1						#print number (set syscall service 1)
			syscall 							#print number - current tempNum1($t0) value
			#print ' '					
			la $k1, printspace 						#print space (load printspace address)
			jalr $k0, $k1 							#print space (jump to printspace then return)
									
		opt11.3.3:						
			#end/continue outerloop	depending on tempNum1($t0) value			
			beq $t0, $t2, opt11.5						#if reached end, jump to endouterloop for value resets (>opt11.5)...		
			beqz $t1, opt11.4 						#if countdown then jump to subtract1 (>opt11.4) and return to outerloop (<opt11.3)
			addi $t0, $t0, 1 						#else tempNum1($t0)++
			j opt11.3 							#continue outerloop (>opt11.3)
									
	opt11.4:							
		#tempNum1($t0)--					
		subi $t0, $t0, 1						#subtract one from tempNum1($t0)
		j opt11.3 							#continue outerloop (>opt11.3)
									
	opt11.5: 							#endouterloop
		#reset all used values to 0				
		addi $t0, $0, 0 						#reset tempNum1($t0) just incase
		addi $t1, $0, 0 						#reset countFlag($t1)
		addi $t2, $0, 0 						#reset tempNum2($t2) just incase
		addi $t4, $0, 0 						#reset subLoopCount($t4) just incase
		addi $t5, $0, 0 						#reset subLoopEndNum($t5) just incase
		addi $t6, $0, 0 						#reset divResult($t6) just incase
		#return to MENU						
		j printMenu 						
									
quit: #Quit								
