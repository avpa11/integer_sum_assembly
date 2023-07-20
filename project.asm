; COMP 2825 Group Project
; Summer 2023 term

SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1


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


section .bss
   num1 resb 2 
   num2 resb 2 
   res  resb 3


section .text
   global _start    

	
_start:             
   mov	edx,len     
   mov	ecx,msg     
   mov	ebx,1       
   mov	eax,4       
   int	0x80        

   mov eax, SYS_WRITE         
   mov ebx, STDOUT         
   mov ecx, msg1         
   mov edx, len1 
   int 0x80                

   mov eax, SYS_READ 
   mov ebx, STDIN  
   mov ecx, num1 
   mov edx, 2
   int 0x80            

   mov eax, SYS_WRITE        
   mov ebx, STDOUT         
   mov ecx, msg2          
   mov edx, len2         
   int 0x80

   mov eax, SYS_READ  
   mov ebx, STDIN  
   mov ecx, num2 
   mov edx, 2
   int 0x80        

   mov al, byte [num1]
   sub al, '0'

   mov bl, byte [num2]
   sub bl, '0'

   add al, bl

   cmp al, 9
   jbe single_digit

   add al, '0' - 10
   mov byte [res], '1' 
   mov byte [res+1], al 

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

   mov eax, SYS_WRITE        
   mov ebx, STDOUT
   mov ecx, msg_newline        
   mov edx, len_newline      
   int 0x80

   mov eax, SYS_EXIT   
   xor ebx, ebx 
   int 0x80

single_digit:
   add al, '0'
   mov byte [res], al

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

   mov eax, SYS_WRITE        
   mov ebx, STDOUT
   mov ecx, msg_newline        
   mov edx, len_newline      
   int 0x80

   mov eax, SYS_EXIT   
   xor ebx, ebx 
   int 0x80
