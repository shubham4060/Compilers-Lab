# Shubham Sharma
# 14CS30034


	.file	"ass1.c"         #   name of program file 
	.section	.rodata    #   read only data
	.align 8
.LC0:
	.string	"Enter how many elements you want:"      # .LC0-label of f-string 1st printf
.LC1:                                                    # .LC1- label of f-string 1st scanf
	.string	"%d"                                        
.LC2:                                                     # .LC2-label of f-string 2nd printf
	.string	"Enter the %d elements:\n"
.LC3:                                                      # .LC3-label of f-string 3rd printf
	.string	"\nEnter the item to search"
.LC4:                                                       # .LC4-label of f-string 4th printf
	.string	"\n%d found in position: %d\n"
.LC5:                                                        # .LC5-label of f-string 5th printf
	.string	"\n%d inserted in position: %d\n"
.LC6:                                                        # .LC6-label of f-string 6th printf
	.string	"The list of %d elements:\n"
.LC7:
	.string	"%6d"
	.text
	.globl	main
	.type	main, @function                              # main is a global function
main:                                                        # main function starting
.LFB0:
	.cfi_startproc
	pushq	%rbp                                         # saving the old base pointer
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp                                   # moving stack pointer to base pointer   rbp <-- rsp
	.cfi_def_cfa_register 6
	subq	$416, %rsp                                   # Allocating space for local array and variables in main program
	movl	$.LC0, %edi                                  # moving 1st printf string .LC0 to register edi used for string copying
	call	puts                                         # display the string stored in edi register
	leaq	-416(%rbp), %rax                             # rax<--rbp-416   storing adress of variable "n" into rax                 
	movq	%rax, %rsi                                   # rsi <-- rax   rsi storing value of rax
	movl	$.LC1, %edi                                  # moving 1st scanf string .LC0 to register edi used for string copying
	movl	$0, %eax                                     # eax <-- 0 so as to store the return value of the scanf
	call	__isoc99_scanf                               # calling scanf which will store the value at adress at rsi that is in "n"  adress of n =rbp-416
	movl	-416(%rbp), %eax                             # storing the value of n(addr=rbp-416) into esi as esi is register for printf operations for values
	movl	%eax, %esi                            
	movl	$.LC2, %edi                                  # moving 2nd printf string .LC0 to register edi used for string copying                              
	movl	$0, %eax                                     # eax <-- 0
	call	printf                                       # calling printf for string just stored above in edi register
	movl	$0, -408(%rbp)                               # variable i is stored at adress rbp-408 , initialising it to 0  M[rbp-408]=0
	jmp	.L2                                          # jumping to for loop section .L2
.L3:                                                        
	leaq	-400(%rbp), %rax                             # rax <-- rbp-400 that is rax stores the starting adress of array
	movl	-408(%rbp), %edx                             # edx <-- m[rbp-408],that is edx stores value of i
	movslq	%edx, %rdx                                   # rdx <-- edx
	salq	$2, %rdx                                     # shift arithmetic to 2 units left, that is rdx= 4 * i that is shift 1 integer ahead
	addq	%rdx, %rax                                   # rax <-- rdx + rax that is rax<-- data + 4*i (data[i])
	movq	%rax, %rsi                                   # rsi <-- rax storing rax ie data+ 4*i into rsi so that scanf stores value in rsi that is data[i]
	movl	$.LC1, %edi                                  # calling scanf
	movl	$0, %eax                                     # eax <-- 0 for storing return value of scanf
	call	__isoc99_scanf
	addl	$1, -408(%rbp)                               # rbp <= rbp +1 that is incrementing i , i=i+1
.L2:                                                         # for loop initialising
	movl	-416(%rbp), %eax                             # storing value of n in eax register for loop operations
	cmpl	%eax, -408(%rbp)                             # comparing value stored in eax with m[rbp-408],that is comparing n with i for loop check condition
	jl	.L3                                          # if i<n that it will do loop operations in .L3
	movl	-416(%rbp), %edx                             # edx <-- m[rbp-416] that is storing n in edx                            
	leaq	-400(%rbp), %rax                             # rax <-- rbp-400 that is storing array starting adress in rax
	movl	%edx, %esi                                   # esi <-- edx esi is register for storing second argument to function
	movq	%rax, %rdi                                   # rdi <-- rax rdi is register for storing first argument to a function
	call	inst_sort                                    # calling insertion sort
	movl	$.LC3, %edi                                  # loading string of .LC3 in edi register
	call	puts                                         # calling printf
	leaq	-412(%rbp), %rax                             # rax <- rbp-412 that is storing adress of variable item
	movq	%rax, %rsi                                   # rsi <-- rax that is rsi stores adress of variable item
	movl	$.LC1, %edi                                  # loading scanf string
	movl	$0, %eax                                     # eax <-- 0 that is eax stores return value of scanf
	call	__isoc99_scanf                               # calling scanf
	movl	-412(%rbp), %edx                             # edx<-- m[rbp-412] that is edx stores item which is third parameter in function binary search
	movl	-416(%rbp), %ecx                             # ecx<-- m[rbp-416] that is ecx stores n which is second parameter in binary search function
	leaq	-400(%rbp), %rax                             # rax<-- rbp-400 that is rax stores array starting adress which is first parameter of binary search function
	movl	%ecx, %esi                                   # esi <-- ecx esi is register for storing 2nd argument of function that is n
	movq	%rax, %rdi                                   # rdi<-- rax  rdi is register for storing first argument to the function which is arrays starting adress
	call	bsearch                                      # calling binary seach function
	movl	%eax, -404(%rbp)                             # m[rbp-404]=eax that is variable loc stores the return value of binary search function
	movl	-404(%rbp), %eax                             # eax <-- m[rbp-404] that is eax stores value of variable loc
	cltq                                             
	movl	-400(%rbp,%rax,4), %edx                      # edx stores value of a[loc]
	movl	-412(%rbp), %eax                             # eax stores value of item(m[rbp-412]) for comparison(if)
	cmpl	%eax, %edx                                     
	jne	.L4
	movl	-404(%rbp), %eax                             # eax <-- m[rbp-404] that is eax stores the valu of loc
	leal	1(%rax), %edx                                # edx stores 3rd argument to printf funtion
	movl	-412(%rbp), %eax                             # eax stores value of variable item
	movl	%eax, %esi                                   # esi stores now value of item which is 2nd argument of printf function
	movl	$.LC4, %edi                                  # loading string in edi which is 1st argument for printf function
	movl	$0, %eax                                     # eax <-- 0 for storing return value
	call	printf                                       # calling printf function
	jmp	.L5
.L4:
	movl	-412(%rbp), %edx                             # edx <-- m[rbp-412] that is edx stores value of variable item which is 3rd argument to function insert
	movl	-416(%rbp), %ecx                             # ecx <- m[rbp-416] that is ecx stores value of variable n
	leaq	-400(%rbp), %rax                             # rax<--rbp-400 that is rax stores starting adress of array
	movl	%ecx, %esi                                   # esi stores now variable n which is 2nd argument to function insert
	movq	%rax, %rdi                                   # rdi stores now array's starting adress which is 1st argument of insert function
	call	insert                                       # calling insert function
	movl	%eax, -404(%rbp)                             # m[rbp-404]=eax that is loc variable stores eax which is return value of function insert
	movl	-416(%rbp), %eax                             # eax<-- m[rbp-416] that is eax stores value of n
	addl	$1, %eax                                     # eax <--  eax+1 that is n++ is executed
	movl	%eax, -416(%rbp)                             # m[rbp-416]<-- eax that is value of n is updated
	movl	-404(%rbp), %eax                             # eax<-- m[rbp-404] eax stores value of loc
	leal	1(%rax), %edx                                # edx<-- rax+1 that is edx stores value of loc+1 , the 3rd argument of printf
	movl	-412(%rbp), %eax                             # eax<-- m[rbp-412] that is eax stores value of var item
	movl	%eax, %esi                                   # esi stores value of item , the 2nd argument of printf
	movl	$.LC5, %edi                                  # loading string into edi the 1st argument for printf funtion
	movl	$0, %eax                                     # eax<--0 for return value of printf
	call	printf                                       # calling prinf function
.L5:
	movl	-416(%rbp), %eax                             # eax stores value of n stored at m[rbp-416]                         
	movl	%eax, %esi                                   # esi stores value of n which is 2 argument to printf
	movl	$.LC6, %edi                                  # loading string into edi which is 1st argument of printf
	movl	$0, %eax                                     # eax<--0 return value of printf
	call	printf                                       # calling printf function
	movl	$0, -408(%rbp)                               # m[rbp-408]=0 that is initialising i=0
	jmp	.L6                                          # jump to .L6
.L7: 
	movl	-408(%rbp), %eax                             # eax <-- m[rbp-408] that is eax stores value of i     
	cltq
	movl	-400(%rbp,%rax,4), %eax                      # eax<-- a + 4*i that is eax stores value of a[i]
	movl	%eax, %esi                                   # esi stores now a[i] so that value read from scanf is stored in a[i]
	movl	$.LC7, %edi                                  # loading string in edi register for scanf
	movl	$0, %eax                                     # eax<--0 for return value
	call	printf                                       # calling printf
	addl	$1, -408(%rbp)                               # incrementing i for next iteration i++
.L6:
	movl	-416(%rbp), %eax                             # eax stores value of n m[rbp-16]
	cmpl	%eax, -408(%rbp)                             # comparing i with n
	jl	.L7                                          # if i<n jump to .L7 for loop operations
	movl	$10, %edi                                    # edi<-- 10 as argument for putchar
	call	putchar                                      # calling putchar for newline "\n"
	movl	$0, %eax                                     # eax<--0 return value for main program (return 0)
	leave                                                # leaving the stack frame
	.cfi_def_cfa 7, 8
	ret                                                  # retur from the main function
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.globl	inst_sort
	.type	inst_sort, @function                        # insertion sort function
inst_sort:
.LFB1:                                                      # function initialises
	.cfi_startproc
	pushq	%rbp                                        # saving old base pointer
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp                                  # rbp<-rsp storing stack pointer in old base pointer
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)                             # m[rbp-24]<-- rdi that is it stores the adress of 1st element of array                   
	movl	%esi, -28(%rbp)                             # m[rbp-28]<-- esi that is it stores the value of n
	movl	$1, -8(%rbp)                                # m[rbp-8]<--1 meaning that j=1 is initialised
	jmp	.L10                                        # jump to .L10
.L14:
	movl	-8(%rbp), %eax                              # eax<-- m[rbp-8] that is eax stores j 
	cltq                                                # convert rax<--eax
	leaq	0(,%rax,4), %rdx                            # solves rdx<- rax*j that is rdx stores 4*j
	movq	-24(%rbp), %rax                             # rax<--m[rbp-24] that is rax stores array 1st element adress
	addq	%rdx, %rax                                  # rax<-- rax+rdx that is rax now stores num+ 4*j which is adress of num[j]
	movl	(%rax), %eax                                # eax now stores value of a[j] 
	movl	%eax, -4(%rbp)                              # m[rbp-4]=a[j] that is k now stores value of a[j] or num[j]
	movl	-8(%rbp), %eax                              # eax now stores value of j
	subl	$1, %eax                                    # eax<--eax-1
	movl	%eax, -12(%rbp)                             # m[rbp-12]<--eax that is i is initialised as j-1
	jmp	.L11                                        # jumping to .L11 for next loop
.L13:
	movl	-12(%rbp), %eax                             # eax stores value of i
	cltq                                                # converts rax<-- eax
	addq	$1, %rax                                    # rax <- rax +1 that is rax stores i+1
	leaq	0(,%rax,4), %rdx                            # rdx stores 4*(i+1)
	movq	-24(%rbp), %rax                             # rdx stores array's first element adress
	addq	%rax, %rdx                                  # rdx stores num+4*(i+1) that is adress of num[i+1]
	movl	-12(%rbp), %eax                             # eax stores i
	cltq                                                # converts rax<--eax
	leaq	0(,%rax,4), %rcx                            # rcx stores 4*i
	movq	-24(%rbp), %rax                             # rax stores array's first element adress
	addq	%rcx, %rax                                  # rax stores num+4*i or adress of num[i]
	movl	(%rax), %eax                                # eax stores value in num[i]
	movl	%eax, (%rdx)                                # num[i+1] now stores eax that is num[i+1]=num[i]
	subl	$1, -12(%rbp)                               # decrementing i that is i=i-1
.L11:
	cmpl	$0, -12(%rbp)                              # comparing i with 0
	js	.L12                                       # it will jump whenever the flag is set
	movl	-12(%rbp), %eax                            # eax stores value of i
	cltq                                               # converts rax<--eax
	leaq	0(,%rax,4), %rdx                           # rdx<- 4*rax that is rdx stores 4*i
	movq	-24(%rbp), %rax                            #  rax<-m[rbp-24] that is rax stores the arrays starting adress
	addq	%rdx, %rax                                 # rax<-- rax+rdx  that is rax stores num+4*i that is the adress of num[i]
	movl	(%rax), %eax                               # eax now stores the value of num[i]
	cmpl	-4(%rbp), %eax                             # comparing k and num[i]
	jg	.L13                                       # jump if k<num[i]
.L12:
	movl	-12(%rbp), %eax                            # eax stores value of i
	cltq                                               # converts rax<-- eax
	addq	$1, %rax                                   # rax<--rax+1 that is i=i+1
	leaq	0(,%rax,4), %rdx                           # rdx<- rax*4 that is rdx will store 4*(i+1)
	movq	-24(%rbp), %rax                            # rax will store arrays first element adress
	addq	%rax, %rdx                                 # rdx<--rdx+rax that is rdx will store num+ 4*(i+1) or adress of num[i+1]
	movl	-4(%rbp), %eax                             # eax will store value of k
	movl	%eax, (%rdx)                               # num[i+1] will now store value of k that is num[i+1]=k
	addl	$1, -8(%rbp)                               # j is now incremented j=j+1
.L10:
	movl	-8(%rbp), %eax                                # eax<-- m[rbp-8] that is eax stores value of j
	cmpl	-28(%rbp), %eax                               # comparing j with n
	jl	.L14                                          # if j<n then go to .L14 to do loop operations 
	popq	%rbp                                          # function is executed and the base pointer is popped
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	inst_sort, .-inst_sort
	.globl	bsearch
	.type	bsearch, @function
bsearch:                                                      # Binary Search starts 
.LFB2:
	.cfi_startproc
	pushq	%rbp                                       # old base pointer is saved
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp                                 # rbp saves the the stack pointer
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)                            # m[rbp-24] stores rdi that is the starting adress of array
	movl	%esi, -28(%rbp)                            # m[rbp-28] stores esi that is value of n
	movl	%edx, -32(%rbp)                            # m[rbp-32] stores edx that is value of item
	movl	$1, -8(%rbp)                               # m[rbp-8]=1 that is bottom =1 is initialised
	movl	-28(%rbp), %eax                            # eax stores m[rbp-28] that is value of n
	movl	%eax, -12(%rbp)                            # m[rbp-12] stores eax that is top stores value of n
.L19:
	movl	-12(%rbp), %eax                            # eax stores value of top
	movl	-8(%rbp), %edx                             # edx stores value of bottom
	addl	%edx, %eax                                 # eax<-- eax+edx that is eax stores top+bottom
	movl	%eax, %edx                                 # edx<--eax that is edx stores top+bottom
	shrl	$31, %edx                                  
	addl	%edx, %eax                   
	sarl	%eax                                       # eax now stores (top+bottom)/2
	movl	%eax, -4(%rbp)                             # m[rbp-4] stores eax that is mid=(top+bottom)/2
	movl	-4(%rbp), %eax                             # eax now stores the value of mid
	cltq                                               # converts rax<-- eax
	leaq	0(,%rax,4), %rdx                           # rdx<- 4*rax that is rdx now stores 4*mid
	movq	-24(%rbp), %rax                            # rax<--m[rbp-24] that is rax stores the starting array adress
	addq	%rdx, %rax                                 # rax<--rax+rdx that is rax stores a+4*mid that is the adress of a[mid]
	movl	(%rax), %eax                               # eax now stores the value of a[mid]
	cmpl	-32(%rbp), %eax                            # comparing item and a[mid]
	jle	.L16                                       # if item > a[mid] jump to .L16
	movl	-4(%rbp), %eax                             # eax now stores mid value
	subl	$1, %eax                                   # eax<--eax-1 that is eax=mid-1
	movl	%eax, -12(%rbp)                            # m[rbp-12]<--eax that is top=mid-1 
	jmp	.L17                                       # jump to .L17
.L16:
	movl	-4(%rbp), %eax                             # eax stores value of mid
	cltq                                               # converts rax<--eax
	leaq	0(,%rax,4), %rdx                           # rdx stores 4*rax that is 4*mid
	movq	-24(%rbp), %rax                            # rax stors array first element adress
	addq	%rdx, %rax                                 # rax<-- rax+rdx that is rax stores a+4*mid that is adress of a[mid]
	movl	(%rax), %eax                               # eax stores the value of a[mid]
	cmpl	-32(%rbp), %eax                            # comparing item and a[mid]
	jge	.L17                                       # if a[mid] <= item then jump to .L17
	movl	-4(%rbp), %eax                             # eax stores value of mid
	addl	$1, %eax                                   # eax<--eax+1 that is eax stores mid+1
	movl	%eax, -8(%rbp)                             # bottom<--mid+1
.L17:
	movl	-4(%rbp), %eax                             # eax stores value of mid
	cltq                                               # converting rax<--eax
	leaq	0(,%rax,4), %rdx                           # rdx stores 4*rax that is 4*mid
	movq	-24(%rbp), %rax                            # rax stors array first element adress
	addq	%rdx, %rax                                 # rax<-- rax+rdx that is rax stores a+4*mid that is adress of a[mid]
	movl	(%rax), %eax                               # eax stores the value of a[mid]
	cmpl	-32(%rbp), %eax                            # comparing item and a[mid]
	je	.L18                                       # if item==a[mid] jump to .L18
	movl	-8(%rbp), %eax                             # eax stores value of bottom
	cmpl	-12(%rbp), %eax                            # comparing top and bottom
	jle	.L19                                       # if bottom<= top the jump to .L19
.L18:
	movl	-4(%rbp), %eax                             # eax stores value of mid which will be returned, as item is found at index mid that is a[mid]==item
	popq	%rbp                                       # base pointer is popped and function execution is completed
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	bsearch, .-bsearch
	.globl	insert
	.type	insert, @function
insert:                                                    # insert function starts 
.LFB3:
	.cfi_startproc
	pushq	%rbp                                       # saving old base pointer
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp                                 # storing stack pointer into base pointer
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)                            # m[rbp-24]<--rdi that is it stores the array starting adress
	movl	%esi, -28(%rbp)                            # m[rbp-28]<--esi that is it stores the value of n
	movl	%edx, -32(%rbp)                            # m[rbp-32]<--edx that is stores value of k
	movl	-28(%rbp), %eax                            # eax stores value of n
	subl	$1, %eax                                   # eax<-- eax-1
	movl	%eax, -4(%rbp)                             # m[rbp-4]<--eax that is i=n-1 is initialised
	jmp	.L22                                       # jump to .L22
.L24:
	movl	-4(%rbp), %eax                             # eax stores the value of i
	cltq                                               # converts rax<--eax
	addq	$1, %rax                                   # rax<--rax+1 that is rax stores i+1
	leaq	0(,%rax,4), %rdx                           # rdx stores 4*rax that is 4*(i+1)
	movq	-24(%rbp), %rax                            # rax stors array first element adress  
	addq	%rax, %rdx                                 # rdx<-- rax+rdx that is rax stores num+4*(i+1) that is adress of num[i+1]
	movl	-4(%rbp), %eax                             # eax stores  the value of i
	cltq                                               # converting rax<--eax
	leaq	0(,%rax,4), %rcx                           # rcx stores 4*rax that is 4*i
	movq	-24(%rbp), %rax                            # rax stors array first element adress
	addq	%rcx, %rax                                 # rax<--rax+rcx that is rax contains num+4*i or adress of num[i]
	movl	(%rax), %eax                               # eax stores value of num[i]
	movl	%eax, (%rdx)                               # eax is stored in rdx that is num[i+1]=num[i]
	subl	$1, -4(%rbp)                               # i=i-1 that is i is decremented
.L22:                                              
	cmpl	$0, -4(%rbp)                             # comparing 0 and i 
	js	.L23                                     # jump if the flag is set
	movl	-4(%rbp), %eax                           # eax stores the value of i
	cltq                                             # converting rax<--eax
	leaq	0(,%rax,4), %rdx                         # rdx stores 4*rax that is 4*i
	movq	-24(%rbp), %rax                          # rax stors array first element adress
	addq	%rdx, %rax                               # rax<-- rax+rdx that is rax stores num+4*i that is adress of num[i]
	movl	(%rax), %eax                             # eax stores the value of num[i]
	cmpl	-32(%rbp), %eax                          # comparing k and num[i]
	jg	.L24                                     # if k<num[i] then jump to .L24
.L23:
	movl	-4(%rbp), %eax                           # eax stores the value of i
	cltq                                             # converting rax<--eax
	addq	$1, %rax                                 # rax<--rax+1 that is rax stores i+1
	leaq	0(,%rax,4), %rdx                         # rdx stores 4*i
	movq	-24(%rbp), %rax                          # rax stores arrays first elements adress
	addq	%rax, %rdx                               # rdx<--rdx+rax that is rdx=num+4*i
	movl	-32(%rbp), %eax                          # eax stores the value of k
	movl	%eax, (%rdx)                             # k is stored in num[i] that is num[i]=k
	movl	-4(%rbp), %eax                           # eax stores the value of i
	addl	$1, %eax                                 # eax<--eax+1 that is eax stores i+1 which is the return value
	popq	%rbp                                     # old base pointer is popped
	.cfi_def_cfa 7, 8
	ret                                              # function is completed and value of (i+1) is returned
	.cfi_endproc
.LFE3:
	.size	insert, .-insert
	.ident	"GCC: (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4"
	.section	.note.GNU-stack,"",@progbits
