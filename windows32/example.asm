; Example assembly language program -- adds two numbers
; Author:  R. Detmer
; Date:    1/2008

.586
.MODEL FLAT

INCLUDE io.h            ; header file for input/output

.STACK 4096

.DATA
n DWORD 6
r DWORD 2
result DWORD ?

.CODE
_MainProc PROC

mov EAX, n
mov EBX, r

call MyPerm

MyPerm PROC
push EBP		; begin stack
mov EBP, ESP	; getting stack itself
sub ESP, 4
push EBX		; pushes r [EBP + 8]
push EAX		; pushes n [EBP + 12]
call myFac		; does factorial for n
mov DWORD PTR [EBP - 4], EAX

pop EAX			; gives us back n
pop EBX
sub EAX, EBX	; getting (n - r) into EAX
call myFac		; doing factorial on EAX


mov EBX, EAX						; value of (n - r)! into EBX
mov EAX, DWORD PTR [EBP - 4]		; moving n! back into EAX
div EBX								; dividing n! = EAX with (n - r)! = EBX

pop EBX
mov EBP, ESP
pop EBP
ret

MyPerm ENDP


myFac PROC
cmp EAX, 1
jle FIN			; goes to end if smaller than 1
push EAX		; pushes new value of n - 1
dec EAX			; n - 1
call myFac		; recursion call
pop EBX			
mul EBX
FIN:
ret
myFac ENDP



_MainProc ENDP
END                             ; end of source code

