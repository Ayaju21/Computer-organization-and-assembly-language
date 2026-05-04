
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
   
include 'emu8086.inc'
org 100h 

.model small
.data
    arr db 7 dup(?)        ; store 7 elemnts in array 
.code
main proc
                   
        ;This instruction moves the value of the special symbol @data into the AX register, in x86 assembly 
  mov ax,@data
  mov ds,ax
  
  mov cx,7
  mov si,offset arr 
  
  print "Enter your ID : "    ;program asks the user about id number
   
  loopIn:
  mov ah,1 ; mov data in al register 
  int 21h
  
  mov [si],al
  inc si 
  loop loopIn 
  
  ;new line 
  mov ah,2
  mov dl,10
  int 21h
  
  mov dl,13
  int 21h
  
  mov si,offset arr
  mov cx,7                   ;store this ID in array
   
  print "this ID in array : "      ; [ 1 2 1 1 2 0 7 4 ]
  
  loopOut:
  mov dl,[si]
  mov ah,2
  int 21h
    
    mov dl,32 
    mov ah,2
    int 21h
    
   inc si 
   loop loopOut  
   

   
  mov ax,@data
  mov ds,ax
  
  mov cx,3
  mov si,offset arr 
  
  ;new line
  mov ah,2
  mov dl,10
  int 21h
  
  mov dl,13
  int 21h
 
  print "Do you have partners in your team ?  "    ; if the answer Yes, repeat same steps
  

      loopS:
  mov ah,1 ; mov data in al register 
  int 21h
  
  mov [si],al
  inc si 
  
      loop loopS 
      
      
  
  mov ax,@data
  mov ds,ax
  
  mov cx,7
  mov si,offset arr 
  
   ;new line
  mov ah,2
  mov dl,10
  int 21h
  
  mov dl,13
  int 21h
  
  print "Enter your ID:"     ; enter my parnter ID 
       loopo:
  
  mov ah,1 ; mov data in al register 
  int 21h
  
  mov [si],al
  inc si 
  loop loopo
  
  ;new line 
  mov ah,2
  mov dl,10
  int 21h
  
  mov dl,13
  int 21h
  
  mov si,offset arr
  mov cx,7   
   
  print "this ID in array:"     ;store the ID for my partener in array like [ 1 2 1 1 1 5 3 ]
     loopOutid2:
  mov dl,[si]
  mov ah,2
  int 21h
    
    mov dl,32 
    mov ah,2
    int 21h
    
    inc si 
    loop loopOutid2  
   
              
               
            
    Menu:       ; Menu have many items
    ;new line
  mov ah,2
  mov dl,10
  int 21h
  
  mov dl,13
  int 21h
  ; Print the menu options
  mov ah, 09h         ; DOS function to print a string
  mov dx, offset MenuText
  int 21h

Loop:
  ; Read the user's choice
  mov ah, 01h         ; DOS function to read a character
  int 21h
  sub al, '0'         ; Convert the character to its numeric value

  ; Handle the user's choice
  cmp al, 1           ; Check if choice == 1
  je DisplayOption
  cmp al, 2           ; Check if choice == 2
  je CountOption
  cmp al, 3           ; Check if choice == 3
  je SumOption
  cmp al, 4           ; Check if choice == 4
  je MeanOption
  cmp al, 5           ; Check if choice == 5
  je MedianOption
  cmp al, 6           ; Check if choice == 6
  je MaxOption
  cmp al, 7           ; Check if choice == 7
  je MinOption
  cmp al, 8           ; Check if choice == 8
  je NewIdOption
  cmp al, 9           ; Check if choice == 9
  je ExitOption
  jmp InvalidOption   ; Jump to invalid input 
  
  
  ;new line
  mov ah,2
  mov dl,10
  int 21h
  
  mov dl,13
  int 21h 
  

DisplayOption:
  ; Call the Display function  "option1"
  push offset IDArray
  call Display
  jmp Loop


CountOption:
  ; Call the Count function    "option2"
  push offset IDArray
  call Count
  jmp Loop

SumOption:
  ; Call the Sum function      "option3"
  push offset IDArray
  call Sum
  jmp Loop

MeanOption:
  ; Call the Mean function     "option4"
  push offset IDArray
  call Mean
  jmp Loop

MedianOption:                     
  ; Call the Median function    "option5"
  push offset IDArray
  call Median
  jmp Loop

MaxOption:
  ; Call the Max function     "option6"
  push offset IDArray
  call Max
  jmp Loop

MinOption:
  ; Call the Min function     "option7"
  push offset IDArray
  call Min
  jmp Loop

NewIdOption:
  ; Call the NewId function    "option8"
  push offset IDArray
  call NewId
  jmp Loop

ExitOption:
  ; call the Exit function       "option9"
  mov ah, 4Ch         
  int 21h

InvalidOption:
  ; Print an invalid input message   "option10"  
  mov ah, 09h         
  int 21h
  jmp Loop 
  
  
  
  

; Display function, display the IDs stored in the array.

Display proc
  array db 1,2,1,2,0,7,4,1,2,1,1,1,5,3 
  
  mov ax,@data
  mov ds,ax
  
  mov si, offset array
  mov cx,14
  
  print "your value in array is : "
   
  loopx:
  mov dl,[si] ; i arr[i] si [si]
  add dl,48   
  mov ah,02h
  int 21h
  
  mov dl,32
  mov ah,02h
  int 21h
  
  inc si  
  loop loopx
  
  mov ah,04ch
  int 21h 
     ret
      Display endp   
          
          
          
 ;Count function 
Count proc 
mov ax, [count] ; Move count to AX
call Display ; Display the count
ret
Count endp
     
     
     
; Sum function  
Sum proc       
 ;IDArray  dd 12345, 6789  ,Example array data
formatString db "%d", 10, 0     ; Format string for printing the sum
mov cx, [count]
mov ax, 0 
sumLoop:
add ax, [bx] ; Add value to sum 
inc bx
loop sumLoop         ;using loop we do not need to write the same code again for each number in array
mov [sum], ax ; Save the sum
call Display ; Display the sum 
ret
Sum endp
   
    
    
; Mean function
Mean proc
mov ax, [sum] ; Move sum to AX
mov bx, [count] ; Move count to BX
cwd ; 
idiv bx ; Divide DX:AX by BX to count Mean
mov [mean], ax ; Save the mean
call Display ; Display the mean 
ret
Mean endp
 

; Median function
Median proc   
add al, [bx] ; Add the first value
add al, [bx] ; Add the second value 
mov ax, [sum] ; Move sum for first value and second value
shr al, 1 ; Divide by 2
mov [median], al ; Save the median
call Display ; Display the median  
ret
 Median endp
 
     
     
     
; Max function
Max proc
mov cx, [count]
mov al, [bx]
maxLoop:
cmp al, [bx]
jle maxSkip ; Skip if value is not greater
mov al, [bx]
maxSkip:
inc bx
loop maxLoop
call Display ; Display the maximum value
ret
Max endp

 

; Min function
Min proc
mov cx, [count]
mov al, [bx]
minLoop:
cmp al, [bx]
jge minSkip ; Skip if value is not smaller
mov al, [bx]
minSkip:
inc bx
loop minLoop
call Display ; Display the minimum value
ret
Min endp

  
 
; NewId function
NewId proc
add bx, [count] 
call Display ; Collect a new ID
ret
NewId endp
      
      
      
; EXIT function
; the menu will be closed when you choose this option 
 Exit proc
  ret
 Exit endp
     
; Data section
IDArray dw 1, 2, 3, 4, 5   ; Example array of IDs

   
   ;for Menu
MenuText db "MENU", 0Dh, 0Ah    
db "1. DISPLAY", 0Dh, 0Ah
db "2. COUNTS", 0Dh, 0Ah
db "3. SUM", 0Dh, 0Ah
db "4. MEAN", 0Dh, 0Ah
db "5. MEDIAN", 0Dh, 0Ah
db "6. MAX", 0Dh, 0Ah
db "7. MIN", 0Dh, 0Ah
db "8. NEW ID", 0Dh, 0Ah
db "9. EXIT", 0Dh, 0Ah
"$"InvalidInputText db "Menu option, choose wisely ... ",0Ah, "$"

end main
ret