; COMP 2825 Group Project
; Summer 2023 term

; system call numbers
SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
; file descriptors
STDIN     equ 0
STDOUT    equ 1


; declaring and initializes messages displayed to a user
section .data
   msg db 'A sum of any two single digit integers', 0xa, 0xD
   len equ $ - msg

   msg1 db "Enter a single digit integer: ", 0xA 
   len1 equ $- msg1 

   msg2 db "Enter the second single digit integer: ", 0xA 
   len2 equ $- msg2 

   msg3 db "The sum is: "
   len3 equ $- msg3

   msg_newline db 0xa
   len_newline equ $ - msg_newline

; declaring variables for 2 user inputs and 1 result
section .bss
   num1 resb 2 
   num2 resb 2 
   res  resb 3


section .text
   global _start    

	
_start:
   ; display the first message "A sum of any two single digit integers"
   mov	edx,len     
   mov	ecx,msg     
   mov	ebx,1       
   mov	eax,4       
   int	0x80        

   ; display the message asking for the first user input
   mov eax, SYS_WRITE         
   mov ebx, STDOUT         
   mov ecx, msg1         
   mov edx, len1 
   int 0x80                

   ; read the first user input
   mov eax, SYS_READ 
   mov ebx, STDIN  
   mov ecx, num1 
   mov edx, 2
   int 0x80            

   ; display the message asking for the second user input
   mov eax, SYS_WRITE        
   mov ebx, STDOUT         
   mov ecx, msg2          
   mov edx, len2         
   int 0x80

   ; read the second user input
   mov eax, SYS_READ  
   mov ebx, STDIN  
   mov ecx, num2 
   mov edx, 2
   int 0x80        

   ; the inputs are retrieved, converted from ASCII to integer form, and added together
   mov al, byte [num1]
   sub al, '0'

   mov bl, byte [num2]
   sub bl, '0'

   add al, bl

   ; compare the sum in al to 9
   cmp al, 9
   jbe single_digit

   ; for double digit sum
   add al, '0' - 10
   mov byte [res], '1' 
   mov byte [res+1], al 

   ; display the message for the sum
   mov eax, SYS_WRITE        
   mov ebx, STDOUT
   mov ecx, msg3         
   mov edx, len3        
   int 0x80

   mov eax, SYS_WRITE        
   mov ebx, STDOUT
   mov ecx, res         
   mov edx, 2        
   int 0x80

   ; print the new line message
   mov eax, SYS_WRITE        
   mov ebx, STDOUT
   mov ecx, msg_newline        
   mov edx, len_newline      
   int 0x80

   ; exit
   mov eax, SYS_EXIT   
   xor ebx, ebx 
   int 0x80

single_digit:
   add al, '0'
   mov byte [res], al

   ; display the message for the sum
   mov eax, SYS_WRITE        
   mov ebx, STDOUT
   mov ecx, msg3         
   mov edx, len3        
   int 0x80

   mov eax, SYS_WRITE        
   mov ebx, STDOUT
   mov ecx, res         
   mov edx, 1        
   int 0x80

   ; print the new line message
   mov eax, SYS_WRITE        
   mov ebx, STDOUT
   mov ecx, msg_newline        
   mov edx, len_newline      
   int 0x80

   ; exit
   mov eax, SYS_EXIT   
   xor ebx, ebx 
   int 0x80
