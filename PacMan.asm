INCLUDE Irvine32.inc
BUFFER_SIZE = 5000

.data

;page1
Prompt1 BYTE " ___    _    ___  .  .   _   .  .",0ah
        BYTE "                                        |___|  /_\  |     |\/|  /_\  |\ |",0ah
        BYTE "                                        |     /   \ |     |  | /   \ | \|",0ah
        BYTE "                                                     ---  ",0
Prompt2 BYTE "Game Paused",0


;Menu

newline BYTE    13, 10, 0
option1    BYTE    "1. Start Game", 0
option2    BYTE    "2. High Scores", 0
option3    BYTE    "3. Levels", 0
option4    BYTE    "4. Instruction", 0
option5    BYTE    "5. Quit", 0
option31    BYTE    "1. Level 1", 0
option32    BYTE    "2. Level 2", 0
option33    BYTE    "3. Level 3", 0
;
;Highscore

    buffer BYTE BUFFER_SIZE DUP(?)
    filename BYTE "Highscore.txt"
    fileHandle HANDLE ?
        bytesWritten DWORD ?
        stringL DWORD ?
;
;Instructions
line1 BYTE "RULES:",0
line2 BYTE "X is your player, . is coin, G are the ghost",0
line3 BYTE "Avoid ghost to live, collect coin to score",0
line4 BYTE "CONTROLS:",0
line5 BYTE "W to move up, A to move left, S to move Down, D to move right",0
line6 BYTE "Press x to exit any page",0
;

;Level
level1 BYTE 100 Dup(0)
level2 BYTE 150 Dup(0)
level3 BYTE 250 Dup(0)
ghostCordinate BYTE 6 Dup(0)
ghostCordinate3 BYTE 10 Dup(0)
xpostemp BYTE ?
ypostemp BYTE ?
loopstomove BYTE 20
lpm BYTE 8
loopforfruit BYTE 100
fruitxpos BYTE 200
fruitypos BYTE 200
portal BYTE 0,5,80,15,60,1,20,20
;

ground BYTE "---------------------------------------------------------------------------------",0
ground1 BYTE "|",0ah,0
ground2 BYTE "|",0

temp byte ?

strScore BYTE "Score for this level is: ",0
strtScore BYTE "Your Total score is: ",0
strlives BYTE "Lives: ",0
strscore1 BYTE "Score: ",0
strc BYTE "Press space to continue...",0
lives BYTE 3
score WORD 0
totalscore WORD 0

xPos BYTE 1
yPos BYTE 2

coin BYTE 1422 dup(0)
xCoinPos BYTE ?
yCoinPos BYTE ?

inputChar BYTE ?
input BYTE ?

strname BYTE "Enter Your name: ",0
strname1 BYTE "Player name: ",0
pname BYTE ?

.code
main PROC
    
    call Page1

    exit
main ENDP

Page1 PROC
    


    mov eax, yellow ; Set text color to yellow
    call SetTextColor

    mov dl, 40 ; Set x-position
    mov dh, 12 ; Set y-position
    call Gotoxy

    mov edx, OFFSET prompt1
    call WriteString

    mov eax, 2000
    call Delay

    call Clrscr
    call Menuu
    ret
Page1 ENDP

Menuu PROC
    mov eax, 0
    call Clrscr

    printMenu:
    ;
    call clrscr
    mov eax, yellow
    call SetTextColor
    mov dl, 50 ; Set x-position
    mov dh, 10 ; Set y-position
    call Gotoxy
    mov edx, OFFSET option1
    call WriteString
    mov edx, OFFSET newline
    call WriteString
    ;
    mov eax, blue
    call SetTextColor
    mov dl, 50 ; Set x-position
    mov dh, 11 ; Set y-position
    call Gotoxy
    mov edx, OFFSET option2
    call WriteString
    mov edx, OFFSET newline
    call WriteString
    ;
    mov eax, cyan
    call SetTextColor
    mov dl, 50 ; Set x-position
    mov dh, 12 ; Set y-position
    call Gotoxy
    mov edx, OFFSET option3
    call WriteString
    mov edx, OFFSET newline
    call WriteString
    ;
    mov eax, brown
    call SetTextColor
    mov dl, 50 ; Set x-position
    mov dh, 13 ; Set y-position
    call Gotoxy
    mov edx, OFFSET option4
    call WriteString
    mov edx, OFFSET newline
    call WriteString
    ;
    mov eax, red
    call SetTextColor
    mov dl, 50 ; Set x-position
    mov dh, 14 ; Set y-position
    call Gotoxy
    mov edx, OFFSET option5
    call WriteString
    mov edx, OFFSET newline
    call WriteString
    ;

    mov dl, 50 ; Set x-position
    mov dh, 15 ; Set y-position
    call Gotoxy

    menuloop:
        call ReadChar
        mov inputChar,al

    cmp inputChar,"1"
    je  startGame
    cmp inputChar,"2"
    je  highScores
    cmp inputChar,"3"
    je  level
    cmp inputChar,"4"
    je  instructionl
    cmp inputChar,"5"
    je  quit

    jmp menuloop

    startGame:
    ; Add code to start the Pac-Man game here
    mov eax,green
    call settextcolor
        call Clrscr
    mov dl,40
    mov dh, 12
    call GoToxy
    mov edx,offset strname
    call writestring
    mov edx, offset pname
    mov ecx,255
    call Readstring
    mov stringL, eax   
    call Clrscr
    mov al,1
    mov al,1
    call Game
    ; You can call a separate function or include the game code directly

    jmp printMenu

    highScores:
    ; Add code to display high scores here
    ; You can call a separate function or include the high scores code directly

    jmp printMenu

    level:
    ; Add code to display levels here
    call clrscr
    call levelm
    ;
    ml:
            call Readchar
        mov inputChar,al

    cmp inputChar,"1"
    je  l1
    cmp inputChar,"2"
    je  l2
    cmp inputChar,"3"
    je  l3
    cmp inputChar,"x"
    je  printmenu

    jmp ml
    ;

    l1:
        call Clrscr
            mov eax,green
    call settextcolor
    mov dl,40
    mov dh, 12
    call GoToxy
    mov edx,offset strname
    call writestring
    mov edx, offset pname
    mov ecx,255
    call Readstring
      mov stringL, eax   
    call Clrscr
    mov al,1
    mov al,1
    call Game
    jmp printmenu

        l2:
            call Clrscr
                mov eax,green
    call settextcolor
    mov dl,40
    mov dh, 12
    call GoToxy
    mov edx,offset strname
    call writestring
    mov edx, offset pname
    mov ecx,255
    call Readstring
      mov stringL, eax   
    call Clrscr
    mov al,1
    mov al,2
    call Game
    jmp printmenu

        l3:
            call Clrscr
                mov eax,green
    call settextcolor
    mov dl,40
    mov dh, 12
    call GoToxy
    mov edx,offset strname
    call writestring
    mov edx, offset pname
    mov ecx,255
    call Readstring
      mov stringL, eax   
    call Clrscr
    mov al,1
    mov al,3
    call Game
    jmp printmenu

    ; You can call a separate function or include the high scores code directly

    jmp printMenu

    instructionl:
    ; Add code to display instruction here
    call Instruction
    ; 

    jmp printMenu

    quit:
    mov eax, white
    call SetTextColor
    call Clrscr
    ret
Menuu ENDP

levelm PROC
    mov eax, cyan
    call SetTextColor
    mov dl, 50 ; Set x-position
    mov dh, 10 ; Set y-position
    call Gotoxy
    mov edx, OFFSET option31
    call WriteString
    mov edx, OFFSET newline
    call WriteString
    ;
    mov dl, 50 ; Set x-position
    mov dh, 11 ; Set y-position
    call Gotoxy
    mov edx, OFFSET option32
    call WriteString
    mov edx, OFFSET newline
    call WriteString
    ;
    mov dl, 50 ; Set x-position
    mov dh, 12 ; Set y-position
    call Gotoxy
    mov edx, OFFSET option33
    call WriteString
    mov edx, OFFSET newline
    call WriteString

        mov dl, 50 ; Set x-position
    mov dh, 13 ; Set y-position
    call Gotoxy

ret
levelm ENDP

Instruction PROC

    call Clrscr    
    mov eax, brown
    call SetTextColor
    mov dl, 35 ; Set x-position
    mov dh, 9 ; Set y-position
        call Gotoxy
    mov edx, OFFSET line1
    call WriteString
    mov edx, OFFSET newline
    call WriteString
    mov dl, 35 ; Set x-position
    mov dh, 10 ; Set y-position
            call Gotoxy
    mov edx, OFFSET line2
    call WriteString
    mov edx, OFFSET newline
    call WriteString
    mov dl, 35 ; Set x-position
    mov dh, 11 ; Set y-position
        call Gotoxy
    mov edx, OFFSET line3
    call WriteString
    mov edx, OFFSET newline
    call WriteString
    mov dl, 35 ; Set x-position
    mov dh, 12 ; Set y-position
        call Gotoxy
    mov edx, OFFSET line4
    call WriteString
    mov edx, OFFSET newline
    call WriteString
    mov dl, 35 ; Set x-position
    mov dh, 13 ; Set y-position
            call Gotoxy
    mov edx, OFFSET line5
    call WriteString
    mov edx, OFFSET newline
    call WriteString
    mov dl, 35 ; Set x-position
    mov dh, 14 ; Set y-position
        call Gotoxy
    mov edx, OFFSET line6
    call WriteString
    mov edx, OFFSET newline
    call WriteString

    mov dl, 35 ; Set x-position
    mov dh, 15 ; Set y-position
    call Gotoxy

    instructionloop:
    call ReadChar
    mov inputChar,al

    cmp inputChar,"x"
    je  quit

    jmp instructionloop

    quit:
    call Clrscr

    ret
Instruction ENDP


Game PROC

cmp al,1
je l1
cmp al,2
je l2
cmp al,3
je l3

jmp ext

l1:
call level_1
mov temp,0
mov ax,score
mov totalscore,ax
cmp inputchar,"x"
jmp ext
l2:
call level_2
mov temp,0
        mov ax,totalscore
        add ax,score
        mov totalscore,ax
cmp inputchar,"x"
jmp ext
l3:
call level_3
mov temp,0
        mov ax,totalscore
        add ax,score
        mov totalscore,ax
ext:

    mov edx,OFFSET filename
    call CreateOutputFile
    mov fileHandle, eax
    cmp eax, INVALID_HANDLE_VALUE  
    jne letsWriteToFile 
    jmp quit
    letsWriteToFile:
    mov eax, fileHandle
    mov edx, OFFSET pname
    mov ecx, stringL
    call WriteToFile
    mov bytesWritten, eax
    mov eax, fileHandle
    mov edx, OFFSET totalscore
    mov ecx, 2
    call WriteToFile
    call CloseFile
    mov eax, bytesWritten
    quit:

call clrscr

    mov eax, blue
    call SetTextColor
    mov dl, 50 ; Set x-position
    mov dh, 11 ; Set y-position
    call Gotoxy
    mov edx, OFFSET strname1
    call WriteString
    mov edx, OFFSET pname
    call WriteString
    mov edx, OFFSET newline
    call WriteString
        mov eax, green
    call SetTextColor
    mov dl, 50 ; Set x-position
    mov dh, 12 ; Set y-position
    call Gotoxy
    mov edx, OFFSET strscore1
    call WriteString
    mov eax,0
    mov ax, totalscore
    call Writedec
    mov edx, OFFSET newline
    call WriteString
        mov eax, red
    call SetTextColor
        mov dl, 50 ; Set x-position
    mov dh, 13 ; Set y-position
        call Gotoxy
       mov edx, OFFSET strc
    call WriteString

    spC:
             call Readkey
        mov inputChar,al
        cmp inputChar," "
        jne spc

ret
Game ENDP

level_1 PROC
    
    mov lives,3
    mov score,0

    ;draw name
    mov eax,white
    call settextcolor
        mov dl,50
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strname1
        call WriteString
        mov edx,OFFSET pname
        call WriteString
    ;

    call movall1

    call DrawBoundry

    call DrawAllCoin

    call DrawPlayer

    call Randomize

    ;creating walls

    call DrawWalls1
        call spawnGhost1
    call wallovercoin
    call ghostovercoin

    ;

    gameLoop:

        ;to end game
        
        cmp score,1210
        je exitgame
        ;mov bx,1
        ;mov esi,offset coin
        ;l1:
        ;inc bx
        ;cmp bx,20
        ;jge con
        ;mov cx,1
        ;l2:
        ;cmp cx,80
        ;jge l1
        ;mov al,[esi]
        ;cmp al,1
        ;je con
        ;inc esi
        ;jmp l2
        ;con:
        ;cmp al,0
        ;je exitgame
        ;

        mov eax,10
        call Delay
        call DrawPlayer

        ;
        cmp loopstomove,0
        je re
        dec loopstomove
        jmp sc
        re:
        call GhostRandomMovement1
        call GhostIntersection
        mov loopstomove,20
        ;
        
        ;scoring
        sc:
        mov edi, offset coin
        mov eax,0
        mov al,ypos
        sub al,2
        mov bl,78
        mul bl
        add al,xpos
        mov cl,coin[eax]
        cmp cl,1
        jne noscoring
        inc score
        mov coin[eax],0
        noscoring:
        

        ;

        ;
        cmp lives,0
        je exitgame
        ;

        notCollecting:

        mov eax,white (black * 16)
        call SetTextColor

        ; draw score:
        mov dl,0
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strScore
        call WriteString
        mov ax,score
        call Writedec
        ;draw lives
        mov dl,35
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strlives
        call WriteString
        mov eax,0
        mov al,lives
        call Writedec
        ;

        ; draw total  score:
        mov dl,85
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strtScore
        call WriteString
        mov ax,totalscore
        call Writedec
        ;


        onGround:

        ; get user key input:
        call Readkey
        mov inputChar,al

        ; exit game if user types 'x':
        cmp inputChar,"x"
        je exitGame

        cmp inputChar,"w"
        je moveUp

        cmp inputChar,"s"
        je moveDown

        cmp inputChar,"a"
        je moveLeft

        cmp inputChar,"d"
        je moveRight

        cmp inputChar,"p"
        je pse

        cmp lpm,0
        je m
        dec lpm
        jmp gameloop

        m:
        mov lpm,8
        cmp temp,1
        je moveup
        cmp temp,2
        je movedown
        cmp temp,3
        je moveleft
        cmp temp,4
        je moveright

        jmp gameloop

        moveUp:
                mov temp,1
        ; allow player to jump:
        ;
        cmp yPos,3
        jb gameLoop

        mov esi, OFFSET level1
        mov bx,0
        mu1:
        inc bx
        cmp bx,51
        jge mu
        mov dx,[esi]
        cmp dl,xPos
        je checkyposu
        inc esi
        inc esi
        jmp mu1
        checkyposu:
        mov dx,[esi+1]
        add dx,1
        cmp dl,yPos
        je gameLoop
        inc esi
        inc esi
        cmp bx,51
        jne mu1

        mu:
        ;
            call UpdatePlayer
            dec yPos
            call DrawPlayer
                    call GhostIntersection
        jmp gameLoop

        moveDown:
        ;
        mov temp,2
        cmp yPos,19
        jge gameLoop

        mov esi, OFFSET level1
        mov bx,0
        md1:
        inc bx
        cmp bx,51
        jge md
        mov dx,[esi]
        cmp dl,xPos
        je checkyposd
        inc esi
        inc esi
        jmp md1
        checkyposd:
        mov dx,[esi+1]
        sub dx,1
        cmp dl,yPos
        je gameLoop
        inc esi
        inc esi
        cmp bx,51
        jne md1

        md:

        ;

        call UpdatePlayer
        inc yPos
        call DrawPlayer
                call GhostIntersection
        jmp gameLoop

        moveLeft:
        ;
                mov temp,3
        cmp xPos,2
        jb gameLoop

        mov esi, OFFSET level1
        mov bx,0
        ml1:
        inc bx
        cmp bx,51
        jge ml
        mov dx,[esi+1]
        cmp dl,yPos
        je checkyposl
        inc esi
        inc esi
        jmp ml1
        checkyposl:
        mov dx,[esi]
        add dx,1
        cmp dl,xPos
        je gameLoop
        inc esi
        inc esi
        cmp bx,51
        jne ml1

        ml:

        ;

        call UpdatePlayer
        dec xPos
        call DrawPlayer
                call GhostIntersection
        jmp gameLoop

        moveRight:
        ;
                mov temp,4
        cmp xPos,79
        jge gameLoop

        mov esi, OFFSET level1
        mov bx,0
        mr1:
        inc bx
        cmp bx,51
        jge mr
        mov dx,[esi+1]
        cmp dl,yPos
        je checkyposr
        inc esi
        inc esi
        jmp mr1
        checkyposr:
        mov dx,[esi]
        sub dx,1
        cmp dl,xPos
        je gameLoop
        inc esi
        inc esi
        cmp bx,51
        jne mr1

        mr:
        ;
        call UpdatePlayer
        inc xPos
        call DrawPlayer
        call GhostIntersection
        jmp gameLoop

    jmp gameLoop

        pse:
        mov dl, 50
        mov dh, 80
        call GoToxy
        mov edx,OFFSET prompt2
        call Writestring
        mov dl, 110
        mov dh, 95
        call GoToxy
        call ReadChar
        mov inputChar,al
        cmp inputChar,"p"
        je gameLoop
        jmp pse

        decliv:
        dec lives
        mov al,0
        mov [esi],al
        mov al,50
        mov [esi+1],al
        jmp gameLoop

        ;

    exitGame:
    call Clrscr
    ret
level_1 ENDP

level_2 PROC
    
    mov loopforfruit,100
    mov loopstomove,15
    mov lives,3
    mov score,0

    ;draw name
    mov eax,white
    call settextcolor
        mov dl,50
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strname1
        call WriteString
        mov edx,OFFSET pname
        call WriteString
    ;

    call movall1

    call DrawBoundry

    call DrawAllCoin

    call DrawPlayer

    call Randomize

    ;creating walls

    call DrawWalls2
        call spawnGhost2
    call wallovercoin2
    call ghostovercoin

    ;

    gameLoop:

        ;to end game
        
        cmp score,1500
        je exitgame
        ;mov bx,1
        ;mov esi,offset coin
        ;l1:
        ;inc bx
        ;cmp bx,20
        ;jge con
        ;mov cx,1
        ;l2:
        ;cmp cx,80
        ;jge l1
        ;mov al,[esi]
        ;cmp al,1
        ;je con
        ;inc esi
        ;jmp l2
        ;con:
        ;cmp al,0
        ;je exitgame
        ;

        mov eax,10
        call Delay
        call DrawPlayer


        ;draw fruit
        cmp fruitxpos,200
        jne gm 
        cmp loopforfruit,0
        je drf
        dec loopforfruit
        jmp gm
        drf:
        call DrawFruit2
        mov loopforfruit,100
        ;
        ;ghost movement
        gm:
        cmp loopstomove,0
        je re
        dec loopstomove
        jmp sc
        re:
        call GhostRandomMovement2
        call GhostIntersection
        mov loopstomove,15
        ;
        
        ;scoring
        sc:
        mov edi, offset coin
        mov eax,0
        mov al,ypos
        sub al,2
        mov bl,78
        mul bl
        add al,xpos
        mov cl,coin[eax]
        cmp cl,1
        jne noscoring
        inc score
        mov coin[eax],0
        noscoring:
        

        ;

        ;
        cmp lives,0
        je exitgame
        ;

        notCollecting:

        mov eax,white (black * 16)
        call SetTextColor

        ; draw score:
        mov dl,0
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strScore
        call WriteString
        mov ax,score
        call Writedec
        ;draw lives
        mov dl,35
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strlives
        call WriteString
        mov eax,0
        mov al,lives
        call Writedec
        ;

        ; draw total  score:
        mov dl,85
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strtScore
        call WriteString
        mov ax,totalscore
        call Writedec
        ;


        onGround:

        ; get user key input:
        call Readkey
        mov inputChar,al

        ; exit game if user types 'x':
        cmp inputChar,"x"
        je exitGame

        cmp inputChar,"w"
        je moveUp

        cmp inputChar,"s"
        je moveDown

        cmp inputChar,"a"
        je moveLeft

        cmp inputChar,"d"
        je moveRight

        cmp inputChar,"p"
        je pse

        cmp lpm,0
        je m
        dec lpm
        jmp gameloop

        m:
        mov lpm,6
        cmp temp,1
        je moveup
        cmp temp,2
        je movedown
        cmp temp,3
        je moveleft
        cmp temp,4
        je moveright

        moveUp:
        ; allow player to jump:
        ;
        mov temp,1
        cmp yPos,3
        jb gameLoop

        mov esi, OFFSET level2
        mov bx,0
        mu1:
        inc bx
        cmp bx,71
        jge mu
        mov dx,[esi]
        cmp dl,xPos
        je checkyposu
        inc esi
        inc esi
        jmp mu1
        checkyposu:
        mov dx,[esi+1]
        add dx,1
        cmp dl,yPos
        je gameLoop
        inc esi
        inc esi
        cmp bx,71
        jne mu1

        mu:
        ;
            call UpdatePlayer
            dec yPos
            call DrawPlayer
                    call GhostIntersection
                    call fruitIntersection
        jmp gameLoop

        moveDown:
        ;
        mov temp,2
        cmp yPos,19
        jge gameLoop

        mov esi, OFFSET level2
        mov bx,0
        md1:
        inc bx
        cmp bx,71
        jge md
        mov dx,[esi]
        cmp dl,xPos
        je checkyposd
        inc esi
        inc esi
        jmp md1
        checkyposd:
        mov dx,[esi+1]
        sub dx,1
        cmp dl,yPos
        je gameLoop
        inc esi
        inc esi
        cmp bx,71
        jne md1

        md:

        ;

        call UpdatePlayer
        inc yPos
        call DrawPlayer
                call GhostIntersection
               call fruitIntersection
        jmp gameLoop

        moveLeft:
        ;
        mov temp,3
        cmp xPos,2
        jb gameLoop

        mov esi, OFFSET level2
        mov bx,0
        ml1:
        inc bx
        cmp bx,71
        jge ml
        mov dx,[esi+1]
        cmp dl,yPos
        je checkyposl
        inc esi
        inc esi
        jmp ml1
        checkyposl:
        mov dx,[esi]
        add dx,1
        cmp dl,xPos
        je gameLoop
        inc esi
        inc esi
        cmp bx,71
        jne ml1

        ml:

        ;

        call UpdatePlayer
        dec xPos
        call DrawPlayer
                call GhostIntersection
                call fruitIntersection
        jmp gameLoop

        moveRight:
        ;
        mov temp,4
        cmp xPos,79
        jge gameLoop

        mov esi, OFFSET level2
        mov bx,0
        mr1:
        inc bx
        cmp bx,71
        jge mr
        mov dx,[esi+1]
        cmp dl,yPos
        je checkyposr
        inc esi
        inc esi
        jmp mr1
        checkyposr:
        mov dx,[esi]
        sub dx,1
        cmp dl,xPos
        je gameLoop
        inc esi
        inc esi
        cmp bx,71
        jne mr1

        mr:
        ;
        call UpdatePlayer
        inc xPos
        call DrawPlayer
        call GhostIntersection
        call fruitIntersection
        jmp gameLoop

    jmp gameLoop

        pse:
        mov dl, 50
        mov dh, 80
        call GoToxy
        mov edx,OFFSET prompt2
        call Writestring
        mov dl, 110
        mov dh, 95
        call GoToxy
        call ReadChar
        mov inputChar,al
        cmp inputChar,"p"
        je gameLoop
        jmp pse

        decliv:
        dec lives
        mov al,0
        mov [esi],al
        mov al,50
        mov [esi+1],al
        jmp gameLoop

        ;

    exitGame:
    call Clrscr
    ret
level_2 ENDP

level_3 PROC
    
    mov loopforfruit,200
    mov loopstomove,10
    mov lives,3
    mov score,0

    ;draw name
    mov eax,white
    call settextcolor
        mov dl,50
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strname1
        call WriteString
        mov edx,OFFSET pname
        call WriteString
    ;

    call movall1

    call DrawBoundry

    call DrawAllCoin

    call DrawPlayer

    call Randomize

    ;creating walls

            call DrawPortal3
    call DrawWalls3
        call spawnGhost3
    call wallovercoin3
    call ghostovercoin3

    ;

    gameLoop:

        ;to end game
        
        cmp score,2000
        je exitgame
        ;mov bx,1
        ;mov esi,offset coin
        ;l1:
        ;inc bx
        ;cmp bx,20
        ;jge con
        ;mov cx,1
        ;l2:
        ;cmp cx,80
        ;jge l1
        ;mov al,[esi]
        ;cmp al,1
        ;je con
        ;inc esi
        ;jmp l2
        ;con:
        ;cmp al,0
        ;je exitgame
        ;

        mov eax,10
        call Delay
        call DrawPlayer


        ;draw fruit
        cmp fruitxpos,200
        jne gm 
        cmp loopforfruit,0
        je drf
        dec loopforfruit
        jmp gm
        drf:
        call DrawFruit3
        mov loopforfruit,200
        ;
        ;ghost movement
        gm:
        cmp loopstomove,0
        je re
        dec loopstomove
        jmp sc
        re:
        call GhostRandomMovement3
        call GhostIntersection3
        mov loopstomove,10
        ;
        
        ;scoring
        sc:
        mov edi, offset coin
        mov eax,0
        mov al,ypos
        sub al,2
        mov bl,78
        mul bl
        add al,xpos
        mov cl,coin[eax]
        cmp cl,1
        jne noscoring
        inc score
        mov coin[eax],0
        noscoring:
        

        ;

        ;
        cmp lives,0
        je exitgame
        ;


        notCollecting:

        mov eax,white (black * 16)
        call SetTextColor

        ; draw score:
        mov dl,0
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strScore
        call WriteString
        mov ax,score
        call Writedec
        ;draw lives
        mov dl,35
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strlives
        call WriteString
        mov eax,0
        mov al,lives
        call Writedec
        ;

        ; draw total  score:
        mov dl,85
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strtScore
        call WriteString
        mov ax,totalscore
        call Writedec
        ;

        onGround:

        ; get user key input:
        call Readkey
        mov inputChar,al

        ; exit game if user types 'x':
        cmp inputChar,"x"
        je exitGame

        cmp inputChar,"w"
        je moveUp

        cmp inputChar,"s"
        je moveDown

        cmp inputChar,"a"
        je moveLeft

        cmp inputChar,"d"
        je moveRight

        cmp inputChar,"p"
        je pse

        cmp lpm,0
        je m
        dec lpm
        jmp gameloop

        m:
        mov lpm,3
        cmp temp,1
        je moveup
        cmp temp,2
        je movedown
        cmp temp,3
        je moveleft
        cmp temp,4
        je moveright

        moveUp:
        ; allow player to jump:
        ;
        mov temp,1
        cmp yPos,3
               jae next1
                cmp xpos,60
        jne gameloop
                call UpdatePlayer
        mov xpos,20
        mov ypos,19
        jmp muj


        next1:
        mov esi, OFFSET level3
        mov bx,0
        mu1:
        inc bx
        cmp bx,91
        jge mu
        mov dx,[esi]
        cmp dl,xPos
        je checkyposu
        inc esi
        inc esi
        jmp mu1
        checkyposu:
        mov dx,[esi+1]
        add dx,1
        cmp dl,yPos
        je gameLoop
        inc esi
        inc esi
        cmp bx,91
        jne mu1

        mu:
        ;
            call UpdatePlayer
            dec yPos
            muj:
            call DrawPlayer
                    call GhostIntersection3
                    call fruitIntersection
        jmp gameLoop

        moveDown:
        ;
                mov temp,2
        cmp yPos,19
        jb next
                cmp xpos,20
        jne gameloop
                call UpdatePlayer
        mov xpos,60
        mov ypos,2
        jmp mdj

        next:
        mov esi, OFFSET level3
        mov bx,0
        md1:
        inc bx
        cmp bx,91
        jge md
        mov dx,[esi]
        cmp dl,xPos
        je checkyposd
        inc esi
        inc esi
        jmp md1
        checkyposd:
        mov dx,[esi+1]
        sub dx,1
        cmp dl,yPos
        je gameLoop
        inc esi
        inc esi
        cmp bx,91
        jne md1

        md:

        ;

        call UpdatePlayer
        inc yPos
        mdj:
        call DrawPlayer
                call GhostIntersection3
               call fruitIntersection
        jmp gameLoop

        moveLeft:
        ;
                mov temp,3
        cmp xPos,2
        jge n
        cmp ypos,5
        jne gameloop
                call UpdatePlayer
        mov xpos,79
        mov ypos,15
        jmp mlj

        n:
        mov esi, OFFSET level3
        mov bx,0
        ml1:
        inc bx
        cmp bx,91
        jge ml
        mov dx,[esi+1]
        cmp dl,yPos
        je checkyposl
        inc esi
        inc esi
        jmp ml1
        checkyposl:
        mov dx,[esi]
        add dx,1
        cmp dl,xPos
        je gameLoop
        inc esi
        inc esi
        cmp bx,91
        jne ml1

        ml:

        ;

        call UpdatePlayer
        dec xPos
        mlj:
        call DrawPlayer
                call GhostIntersection3
                call fruitIntersection
        jmp gameLoop

        moveRight:
        ;
                mov temp,4
        cmp xPos,79
        jb nex
        cmp ypos,15
        jne gameloop
                call UpdatePlayer
        mov xpos,1
        mov ypos,5
        jmp mrj

        nex:
        mov esi, OFFSET level3
        mov bx,0
        mr1:
        inc bx
        cmp bx,91
        jge mr
        mov dx,[esi+1]
        cmp dl,yPos
        je checkyposr
        inc esi
        inc esi
        jmp mr1
        checkyposr:
        mov dx,[esi]
        sub dx,1
        cmp dl,xPos
        je gameLoop
        inc esi
        inc esi
        cmp bx,91
        jne mr1

        mr:
        ;
        call UpdatePlayer
        inc xPos
        mrj:
        call DrawPlayer
        call GhostIntersection3
        call fruitIntersection
        jmp gameLoop

    jmp gameLoop

        pse:
        mov dl, 50
        mov dh, 80
        call GoToxy
        mov edx,OFFSET prompt2
        call Writestring
        mov dl, 110
        mov dh, 95
        call GoToxy
        call ReadChar
        mov inputChar,al
        cmp inputChar,"p"
        je gameLoop
        jmp pse

        decliv:
        dec lives
        mov al,0
        mov [esi],al
        mov al,50
        mov [esi+1],al
        jmp gameLoop

        ;

    exitGame:
    call Clrscr
    ret
level_3 ENDP

DrawBoundry PROC
    ; draw ground at (0,29):
    mov eax,blue (blue*16);(black * 16)
    call SetTextColor
    mov dl,0
    mov dh,20
    call Gotoxy
    mov edx,OFFSET ground
    call WriteString
    mov dl,0
    mov dh,1
    call Gotoxy
    mov edx,OFFSET ground
    call WriteString

    mov ecx,18
    mov dh,2
    mov temp,dh
    l1:
    mov dh,temp
    mov dl,0
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    loop l1


    mov ecx,18
    mov dh,2
    mov temp,dh
    l2:
    mov dh,temp
    mov dl,80
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l2
    ret
DrawBoundry ENDP

DrawPlayer PROC
    ; draw player at (xPos,yPos):
    mov eax,yellow ;(blue*16)
    call SetTextColor
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al,"x"
    call WriteChar
    ret
DrawPlayer ENDP

UpdatePlayer PROC
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdatePlayer ENDP

DrawCoin PROC
    mov eax, green ; Set text color to yellow
    call SetTextColor
    mov dl, xCoinPos
    mov dh, yCoinPos
    mov al, '.'
    call WriteChar
    ret
DrawCoin ENDP

DrawWalls1 PROC 

    mov ecx,25
    mov esi, OFFSET level1
    l1:
    call CreateRandomCoin
    mov edi,OFFSET level1
    mov bx,0
        l2:
        inc bx
        cmp bx,50
        jge draw1
        mov dx,[edi]
        cmp dl,xCoinPos
        je checkypos1
        inc edi
        inc edi
        jmp l2
        checkypos1:
        mov dx,[edi+1]
        cmp dl,yCoinPos
        je l1
        inc edi
        inc edi
        cmp bx,50
        jne l2
    draw1:
    mov al,xCoinPos
    mov [esi],al
    inc esi
    mov al,yCoinPos
    mov [esi],al
    inc esi

    mov eax, red ;(red*16) ; Set text color to yellow
    call SetTextColor
    mov dl, xCoinPos
    mov dh, yCoinPos
    call GoToxy
    mov al, '|'
    call WriteChar

    loop l1

    mov ecx, 25
    l3:
    call CreateRandomCoin
    mov edi,OFFSET level1
    mov bx,0
        l4:
        inc bx
        cmp bx,51
        jge draw2
        mov dx,[edi]
        cmp dl,xCoinPos
        je checkypos2
        inc edi
        inc edi
        jmp l4
        checkypos2:
        mov dx,[edi+1]
        cmp dl,yCoinPos
        je l3
        inc edi
        inc edi
        cmp bx,51
        jne l4
    draw2:
    mov al,xCoinPos
    mov [esi],al
    inc esi
    mov al,yCoinPos
    mov [esi],al
    inc esi

    mov eax, red ; Set text color to yellow
    call SetTextColor
    mov dl, xCoinPos
    mov dh, yCoinPos
    call GoToxy
    mov al, '-'
    call WriteChar

    loop l3

    ret
DrawWalls1 ENDP

DrawWalls2 PROC 

    mov ecx,35
    mov esi, OFFSET level2
    l1:
    call CreateRandomCoin
    mov edi,OFFSET level2
    mov bx,0
        l2:
        inc bx
        cmp bx,70
        jge draw1
        mov dx,[edi]
        cmp dl,xCoinPos
        je checkypos1
        inc edi
        inc edi
        jmp l2
        checkypos1:
        mov dx,[edi+1]
        cmp dl,yCoinPos
        je l1
        inc edi
        inc edi
        cmp bx,70
        jne l2
    draw1:
    mov al,xCoinPos
    mov [esi],al
    inc esi
    mov al,yCoinPos
    mov [esi],al
    inc esi

    mov eax, red ;(red*16); Set text color to yellow
    call SetTextColor
    mov dl, xCoinPos
    mov dh, yCoinPos
    call GoToxy
    mov al, '|'
    call WriteChar

    loop l1

    mov ecx, 35
    l3:
    call CreateRandomCoin
    mov edi,OFFSET level2
    mov bx,0
        l4:
        inc bx
        cmp bx,71
        jge draw2
        mov dx,[edi]
        cmp dl,xCoinPos
        je checkypos2
        inc edi
        inc edi
        jmp l4
        checkypos2:
        mov dx,[edi+1]
        cmp dl,yCoinPos
        je l3
        inc edi
        inc edi
        cmp bx,71
        jne l4
    draw2:
    mov al,xCoinPos
    mov [esi],al
    inc esi
    mov al,yCoinPos
    mov [esi],al
    inc esi

    mov eax, red ; Set text color to yellow
    call SetTextColor
    mov dl, xCoinPos
    mov dh, yCoinPos
    call GoToxy
    mov al, '-'
    call WriteChar

    loop l3

    ret
DrawWalls2 ENDP

DrawWalls3 PROC 

    mov ecx,45
    mov esi, OFFSET level3
    l1:
    call CreateRandomCoin
    mov edi,OFFSET level3
    mov bx,0
        l2:
        inc bx
        cmp bx,90
        jge draw1
        mov dx,[edi]
        cmp dl,xCoinPos
        je checkypos1
        inc edi
        inc edi
        jmp l2
        checkypos1:
        mov dx,[edi+1]
        cmp dl,yCoinPos
        je l1
        inc edi
        inc edi
        cmp bx,90
        jne l2
    draw1:
    mov al,xCoinPos
    mov [esi],al
    inc esi
    mov al,yCoinPos
    mov [esi],al
    inc esi

    mov eax, red ;(red*16); Set text color to yellow
    call SetTextColor
    mov dl, xCoinPos
    mov dh, yCoinPos
    call GoToxy
    mov al, '|'
    call WriteChar

    loop l1

    mov ecx, 35
    l3:
    call CreateRandomCoin
    mov edi,OFFSET level3
    mov bx,0
        l4:
        inc bx
        cmp bx,91
        jge draw2
        mov dx,[edi]
        cmp dl,xCoinPos
        je checkypos2
        inc edi
        inc edi
        jmp l4
        checkypos2:
        mov dx,[edi+1]
        cmp dl,yCoinPos
        je l3
        inc edi
        inc edi
        cmp bx,91
        jne l4
    draw2:
    mov al,xCoinPos
    mov [esi],al
    inc esi
    mov al,yCoinPos
    mov [esi],al
    inc esi

    mov eax, red ; Set text color to yellow
    call SetTextColor
    mov dl, xCoinPos
    mov dh, yCoinPos
    call GoToxy
    mov al, '-'
    call WriteChar

    loop l3

    ret
DrawWalls3 ENDP


CreateRandomCoin PROC
    redo:
    mov eax,80
    call RandomRange
    mov xCoinPos,al
    ;
    mov eax, 20
    call RandomRange
    ;
    mov yCoinPos,al
    ;
    cmp xCoinPos,79
    jge redo
    cmp xCoinPos,2
    jb redo
    cmp yCoinPos,20
    jge redo
    cmp yCoinPos,2
    jb redo
    ;

    ret
CreateRandomCoin ENDP

spawnGhost1 PROC

    mov ecx, 3
    mov esi, offset ghostCordinate
    l1:
    call CreateRandomCoin
    mov edi,OFFSET level1
    mov bx,0
        l2:
        inc bx
        cmp bx,50
        jge draw1
        mov dx,[edi]
        cmp dl,xCoinPos
        je checkypos1
        inc edi
        inc edi
        jmp l2
        checkypos1:
        mov dx,[edi+1]
        cmp dl,yCoinPos
        je l1
        inc edi
        inc edi
        cmp bx,50
        jne l2
    draw1:
    mov al,xCoinPos
    mov [esi],al
    inc esi
    mov al,yCoinPos
    mov [esi],al
    inc esi

    mov eax, white ; Set text color to yellow
    call SetTextColor
    mov dl, xCoinPos
    mov dh, yCoinPos
    call GoToxy
    mov al, 'G'
    call WriteChar

    loop l1

ret
spawnGhost1 ENDP

spawnGhost2 PROC

    mov ecx, 3
    mov esi, offset ghostCordinate
    l1:
    call CreateRandomCoin
    mov edi,OFFSET level2
    mov bx,0
        l2:
        inc bx
        cmp bx,70
        jge draw1
        mov dx,[edi]
        cmp dl,xCoinPos
        je checkypos1
        inc edi
        inc edi
        jmp l2
        checkypos1:
        mov dx,[edi+1]
        cmp dl,yCoinPos
        je l1
        inc edi
        inc edi
        cmp bx,70
        jne l2
    draw1:
    mov al,xCoinPos
    mov [esi],al
    inc esi
    mov al,yCoinPos
    mov [esi],al
    inc esi

    mov eax, white ; Set text color to yellow
    call SetTextColor
    mov dl, xCoinPos
    mov dh, yCoinPos
    call GoToxy
    mov al, 'G'
    call WriteChar

    loop l1

ret
spawnGhost2 ENDP

spawnGhost3 PROC

    mov ecx, 5
    mov esi, offset ghostCordinate3
    l1:
    call CreateRandomCoin
    mov edi,OFFSET level3
    mov bx,0
        l2:
        inc bx
        cmp bx,90
        jge draw1
        mov dx,[edi]
        cmp dl,xCoinPos
        je checkypos1
        inc edi
        inc edi
        jmp l2
        checkypos1:
        mov dx,[edi+1]
        cmp dl,yCoinPos
        je l1
        inc edi
        inc edi
        cmp bx,90
        jne l2
    draw1:
    mov al,xCoinPos
    mov [esi],al
    inc esi
    mov al,yCoinPos
    mov [esi],al
    inc esi

    mov eax, white ; Set text color to yellow
    call SetTextColor
    mov dl, xCoinPos
    mov dh, yCoinPos
    call GoToxy
    mov al, 'G'
    call WriteChar

    loop l1

ret
spawnGhost3 ENDP

DrawAllCoin PROC
    
    mov eax, yellow ; Set text color to yellow
    call SetTextColor 
    mov bx,1
    mov esi,offset coin
    l1:
    inc bx
    cmp bx,20
    jge ext
    mov cx,1
    mov dl,cl
    mov dh,bl
    call GoToxy
    l2:
    cmp cx,80
    jge l1
    mov al,[esi]
    cmp al,0
    je nodraw
    mov al, '.'
    call WriteChar
    nodraw:
    inc esi
    inc cx
    mov dl,cl
    call GoToxy
    jmp l2
    ext:

    ret

DrawAllCoin ENDP

movall1 PROC

mov esi,offset coin
mov al,1
mov ecx, 18
l1:
mov bx,80
    l2:
    dec bx
    cmp bx,0
    jbe ext
    mov [esi],al
    inc esi
    jmp l2
    ext:
    loop l1

ret
movall1 ENDP

WalloverCoin PROC

mov esi, offset level1
mov ecx,50
mov coin[0],0
l1:
   mov edi, offset coin
   mov bl,[esi+1]
   sub bl,1
   l2:
   dec bl
   cmp bl,0
   jbe ext
   mov al,79
    l3:
    cmp al,0
    jbe l2
    dec al
    inc edi
    jmp l3
   ext:
   mov al, [esi]
   l4:
   dec al
   cmp al,0
   je change
   inc edi
   jmp l4

   change:

   mov [edi], al

   inc esi
   inc esi
loop l1

ret
WalloverCoin ENDP

WalloverCoin2 PROC

mov esi, offset level2
mov ecx,70
mov coin[0],0
l1:
   mov edi, offset coin
   mov bl,[esi+1]
   sub bl,1
   l2:
   dec bl
   cmp bl,0
   jbe ext
   mov al,79
    l3:
    cmp al,0
    jbe l2
    dec al
    inc edi
    jmp l3
   ext:
   mov al, [esi]
   l4:
   dec al
   cmp al,0
   je change
   inc edi
   jmp l4

   change:

   mov [edi], al

   inc esi
   inc esi
loop l1

ret
WalloverCoin2 ENDP

WalloverCoin3 PROC

mov esi, offset level3
mov ecx,80
mov coin[0],0
l1:
   mov edi, offset coin
   mov bl,[esi+1]
   sub bl,1
   l2:
   dec bl
   cmp bl,0
   jbe ext
   mov al,79
    l3:
    cmp al,0
    jbe l2
    dec al
    inc edi
    jmp l3
   ext:
   mov al, [esi]
   l4:
   dec al
   cmp al,1
   je change
   inc edi
   jmp l4

   change:

   mov [edi], al

   inc esi
   inc esi
loop l1

ret
WalloverCoin3 ENDP


ghostoverCoin PROC

mov esi, offset ghostcordinate
mov ecx,3
mov coin[0],0
l1:
   mov edi, offset coin
   mov bl,[esi+1]
   sub bl,1
   l2:
   dec bl
   cmp bl,0
   jbe ext
   mov al,79
    l3:
    cmp al,0
    jbe l2
    dec al
    inc edi
    jmp l3
   ext:
   mov al, [esi]
   l4:
   dec al
   cmp al,0
   je change
   inc edi
   jmp l4

   change:

   mov [edi], al

   inc esi
   inc esi
loop l1

ret
ghostoverCoin ENDP

ghostoverCoin3 PROC

mov esi, offset ghostcordinate3
mov ecx,5
mov coin[0],0
l1:
   mov edi, offset coin
   mov bl,[esi+1]
   sub bl,1
   l2:
   dec bl
   cmp bl,0
   jbe ext
   mov al,79
    l3:
    cmp al,0
    jbe l2
    dec al
    inc edi
    jmp l3
   ext:
   mov al, [esi]
   l4:
   dec al
   cmp al,0
   je change
   inc edi
   jmp l4

   change:

   mov [edi], al

   inc esi
   inc esi
loop l1

ret
ghostoverCoin3 ENDP

GhostRandomMovement1 PROC

mov ecx, 3
mov edi, offset ghostcordinate
l1:
    mov al, [edi]
    mov xpostemp,al
    mov al, [edi+1]
    mov ypostemp,al
    mov eax,5
    cmp ypostemp,50
    je ext
    call RandomRange
    cmp al,1
    je moveup
    cmp al,2
    je movedown
    cmp al,3
    je moveleft
    cmp al,4
    je moveright

    ext:

    inc edi
    inc edi

loop l1

jmp et

            moveUp:
        ; allow player to jump:
        ;
        cmp ypostemp,3
        jb ext

        mov esi, OFFSET level1
        mov bx,0
        mu1:
        inc bx
        cmp bx,51
        jge mu
        mov dx,[esi]
        cmp dl,xpostemp
        je checkyposu
        inc esi
        inc esi
        jmp mu1
        checkyposu:
        mov dx,[esi+1]
        add dx,1
        cmp dl,ypostemp
        je ext
        inc esi
        inc esi
        cmp bx,51
        jne mu1

        mu:
        ;
            call Updateghost
            dec ypostemp
            mov al,ypostemp
            mov [edi+1],al
            call Drawghost
        jmp ext

        moveDown:
        ;
        cmp yPostemp,19
        jge l1

        mov esi, OFFSET level1
        mov bx,0
        md1:
        inc bx
        cmp bx,51
        jge md
        mov dx,[esi]
        cmp dl,xPostemp
        je checkyposd
        inc esi
        inc esi
        jmp md1
        checkyposd:
        mov dx,[esi+1]
        sub dx,1
        cmp dl,yPostemp
        je l1
        inc esi
        inc esi
        cmp bx,51
        jne md1

        md:

        ;

            call Updateghost
            inc ypostemp
            mov al,ypostemp
            mov [edi+1],al
            call Drawghost
            jmp ext

        moveLeft:
        ;
        cmp xPostemp,2
        jb l1

        mov esi, OFFSET level1
        mov bx,0
        ml1:
        inc bx
        cmp bx,51
        jge ml
        mov dx,[esi+1]
        cmp dl,yPostemp
        je checkyposl
        inc esi
        inc esi
        jmp ml1
        checkyposl:
        mov dx,[esi]
        add dx,1
        cmp dl,xPostemp
        je l1
        inc esi
        inc esi
        cmp bx,51
        jne ml1

        ml:

        ;

            call Updateghost
            dec xpostemp
            mov al,xpostemp
            mov [edi],al
            call Drawghost
        jmp ext

                moveRight:
        ;
        cmp xPostemp,79
        jge l1

        mov esi, OFFSET level1
        mov bx,0
        mr1:
        inc bx
        cmp bx,51
        jge mr
        mov dx,[esi+1]
        cmp dl,yPostemp
        je checkyposr
        inc esi
        inc esi
        jmp mr1
        checkyposr:
        mov dx,[esi]
        sub dx,1
        cmp dl,xPostemp
        je l1
        inc esi
        inc esi
        cmp bx,51
        jne mr1

        mr:
        ;
             call Updateghost
            inc xpostemp
            mov al,xpostemp
            mov [edi],al
            call Drawghost
        jmp ext

        et:
        
ret
GhostRandomMovement1 ENDP

GhostRandomMovement2 PROC

mov ecx, 3
mov edi, offset ghostcordinate
l1:
    mov al, [edi]
    mov xpostemp,al
    mov al, [edi+1]
    mov ypostemp,al
    mov eax,5
    cmp ypostemp,50
    je ext
    call RandomRange
    cmp al,1
    je moveup
    cmp al,2
    je movedown
    cmp al,3
    je moveleft
    cmp al,4
    je moveright

    ext:

    inc edi
    inc edi

loop l1

jmp et

            moveUp:
        ; allow player to jump:
        ;
        cmp ypostemp,3
        jb ext

        mov esi, OFFSET level2
        mov bx,0
        mu1:
        inc bx
        cmp bx,71
        jge mu
        mov dx,[esi]
        cmp dl,xpostemp
        je checkyposu
        inc esi
        inc esi
        jmp mu1
        checkyposu:
        mov dx,[esi+1]
        add dx,1
        cmp dl,ypostemp
        je ext
        inc esi
        inc esi
        cmp bx,71
        jne mu1

        mu:
        ;
            call Updateghost
            dec ypostemp
            mov al,ypostemp
            mov [edi+1],al
            call Drawghost
        jmp ext

        moveDown:
        ;
        cmp yPostemp,19
        jge l1

        mov esi, OFFSET level2
        mov bx,0
        md1:
        inc bx
        cmp bx,71
        jge md
        mov dx,[esi]
        cmp dl,xPostemp
        je checkyposd
        inc esi
        inc esi
        jmp md1
        checkyposd:
        mov dx,[esi+1]
        sub dx,1
        cmp dl,yPostemp
        je l1
        inc esi
        inc esi
        cmp bx,71
        jne md1

        md:

        ;

            call Updateghost
            inc ypostemp
            mov al,ypostemp
            mov [edi+1],al
            call Drawghost
            jmp ext

        moveLeft:
        ;
        cmp xPostemp,2
        jb l1

        mov esi, OFFSET level2
        mov bx,0
        ml1:
        inc bx
        cmp bx,71
        jge ml
        mov dx,[esi+1]
        cmp dl,yPostemp
        je checkyposl
        inc esi
        inc esi
        jmp ml1
        checkyposl:
        mov dx,[esi]
        add dx,1
        cmp dl,xPostemp
        je l1
        inc esi
        inc esi
        cmp bx,71
        jne ml1

        ml:

        ;

            call Updateghost
            dec xpostemp
            mov al,xpostemp
            mov [edi],al
            call Drawghost
        jmp ext

                moveRight:
        ;
        cmp xPostemp,79
        jge l1

        mov esi, OFFSET level2
        mov bx,0
        mr1:
        inc bx
        cmp bx,71
        jge mr
        mov dx,[esi+1]
        cmp dl,yPostemp
        je checkyposr
        inc esi
        inc esi
        jmp mr1
        checkyposr:
        mov dx,[esi]
        sub dx,1
        cmp dl,xPostemp
        je l1
        inc esi
        inc esi
        cmp bx,71
        jne mr1

        mr:
        ;
             call Updateghost
            inc xpostemp
            mov al,xpostemp
            mov [edi],al
            call Drawghost
        jmp ext

        et:
        
ret
GhostRandomMovement2 ENDP

GhostRandomMovement3 PROC

mov ecx, 5
mov edi, offset ghostcordinate3
l1:
    mov al, [edi]
    mov xpostemp,al
    mov al, [edi+1]
    mov ypostemp,al
    mov eax,5
    cmp ypostemp,50
    je ext
    call RandomRange
    cmp al,1
    je moveup
    cmp al,2
    je movedown
    cmp al,3
    je moveleft
    cmp al,4
    je moveright

    ext:

    inc edi
    inc edi

loop l1

jmp et

            moveUp:
        ; allow player to jump:
        ;
        cmp ypostemp,3
        jb ext

        mov esi, OFFSET level3
        mov bx,0
        mu1:
        inc bx
        cmp bx,91
        jge mu
        mov dx,[esi]
        cmp dl,xpostemp
        je checkyposu
        inc esi
        inc esi
        jmp mu1
        checkyposu:
        mov dx,[esi+1]
        add dx,1
        cmp dl,ypostemp
        je ext
        inc esi
        inc esi
        cmp bx,91
        jne mu1

        mu:
        ;
            call Updateghost
            dec ypostemp
            mov al,ypostemp
            mov [edi+1],al
            call Drawghost
        jmp ext

        moveDown:
        ;
        cmp yPostemp,19
        jge l1

        mov esi, OFFSET level3
        mov bx,0
        md1:
        inc bx
        cmp bx,91
        jge md
        mov dx,[esi]
        cmp dl,xPostemp
        je checkyposd
        inc esi
        inc esi
        jmp md1
        checkyposd:
        mov dx,[esi+1]
        sub dx,1
        cmp dl,yPostemp
        je l1
        inc esi
        inc esi
        cmp bx,91
        jne md1

        md:

        ;

            call Updateghost
            inc ypostemp
            mov al,ypostemp
            mov [edi+1],al
            call Drawghost
            jmp ext

        moveLeft:
        ;
        cmp xPostemp,2
        jb l1

        mov esi, OFFSET level3
        mov bx,0
        ml1:
        inc bx
        cmp bx,91
        jge ml
        mov dx,[esi+1]
        cmp dl,yPostemp
        je checkyposl
        inc esi
        inc esi
        jmp ml1
        checkyposl:
        mov dx,[esi]
        add dx,1
        cmp dl,xPostemp
        je l1
        inc esi
        inc esi
        cmp bx,91
        jne ml1

        ml:

        ;

            call Updateghost
            dec xpostemp
            mov al,xpostemp
            mov [edi],al
            call Drawghost
        jmp ext

                moveRight:
        ;
        cmp xPostemp,79
        jge l1

        mov esi, OFFSET level3
        mov bx,0
        mr1:
        inc bx
        cmp bx,91
        jge mr
        mov dx,[esi+1]
        cmp dl,yPostemp
        je checkyposr
        inc esi
        inc esi
        jmp mr1
        checkyposr:
        mov dx,[esi]
        sub dx,1
        cmp dl,xPostemp
        je l1
        inc esi
        inc esi
        cmp bx,91
        jne mr1

        mr:
        ;
             call Updateghost
            inc xpostemp
            mov al,xpostemp
            mov [edi],al
            call Drawghost
        jmp ext

        et:
        
ret
GhostRandomMovement3 ENDP

Drawghost PROC
    ; draw player at (xPos,yPos):
    mov eax,white ;(blue*16)
    call SetTextColor
    mov dl,xPostemp
    mov dh,yPostemp
    call Gotoxy
    mov al,"G"
    call WriteChar
    ret
Drawghost ENDP

Updateghost PROC
    mov eax,yellow ;(blue*16)
    call SetTextColor
    mov dl,xPostemp
    mov dh,yPostemp
    call Gotoxy
    ;check if coin is on or off

        mov eax,0
        mov al,ypostemp
        sub al,2
        mov bl,78
        mul bl
        add al,xpostemp
        mov dl,coin[eax]
        cmp dl,0
        je drawspace
    mov al,"."
    call WriteChar
    jmp ext
    drawspace:
        mov al," "
    call WriteChar

    ext:
    ;
    ret
Updateghost ENDP

GhostIntersection PROC
        mov esi,OFFSET ghostCordinate
        mov bx,0
        gi1:
        inc bx
        cmp bx,4
        jge gi
        mov dx,[esi]
        cmp dl,xPos
        je checkyposgi
        inc esi
        inc esi
        jmp gi1
        checkyposgi:
        mov dx,[esi+1]
        cmp dl,yPos
        je decliv
        inc esi
        inc esi
        cmp bx,4
        jne gi1

        gi:

        jmp ext

        decliv:
        dec lives
        mov al,0
        mov [esi],al
        mov al,50
        mov [esi+1],al
        jmp gi1

        ext:

        ret 
GhostIntersection ENDP

GhostIntersection3 PROC
        mov esi,OFFSET ghostCordinate3
        mov bx,0
        gi1:
        inc bx
        cmp bx,6
        jge gi
        mov dx,[esi]
        cmp dl,xPos
        je checkyposgi
        inc esi
        inc esi
        jmp gi1
        checkyposgi:
        mov dx,[esi+1]
        cmp dl,yPos
        je decliv
        inc esi
        inc esi
        cmp bx,6
        jne gi1

        gi:

        jmp ext

        decliv:
        dec lives
        mov al,0
        mov [esi],al
        mov al,50
        mov [esi+1],al
        jmp gi1

        ext:

        ret 
GhostIntersection3 ENDP

DrawFruit2 PROC
l1:
    call CreateRandomCoin
    mov edi,OFFSET level2
    mov bx,0
        l2:
        inc bx
        cmp bx,70
        jge draw1
        mov dx,[edi]
        cmp dl,xCoinPos
        je checkypos1
        inc edi
        inc edi
        jmp l2
        checkypos1:
        mov dx,[edi+1]
        cmp dl,yCoinPos
        je l1
        inc edi
        inc edi
        cmp bx,70
        jne l2
    draw1:


        mov edi,OFFSET ghostcordinate
        mov bx,0
        l3:
        inc bx
        cmp bx,3
        jge draw2
        mov dx,[edi]
        cmp dl,xCoinPos
        je checkypos2
        inc edi
        inc edi
        jmp l3
        checkypos2:
        mov dx,[edi+1]
        cmp dl,yCoinPos
        je l1
        inc edi
        inc edi
        cmp bx,3
        jne l3

        draw2:

    mov al,xCoinPos
    mov fruitxpos,al
    mov al,yCoinPos
    mov fruitypos,al

    mov eax, cyan ; Set text color to yellow
    call SetTextColor
    mov dl, xCoinPos
    mov dh, yCoinPos
    call GoToxy
    mov al, '*'
    call WriteChar

ret
DrawFruit2 ENDP

DrawFruit3 PROC
l1:
    call CreateRandomCoin
    mov edi,OFFSET level3
    mov bx,0
        l2:
        inc bx
        cmp bx,90
        jge draw1
        mov dx,[edi]
        cmp dl,xCoinPos
        je checkypos1
        inc edi
        inc edi
        jmp l2
        checkypos1:
        mov dx,[edi+1]
        cmp dl,yCoinPos
        je l1
        inc edi
        inc edi
        cmp bx,90
        jne l2
    draw1:


        mov edi,OFFSET ghostcordinate3
        mov bx,0
        l3:
        inc bx
        cmp bx,5
        jge draw2
        mov dx,[edi]
        cmp dl,xCoinPos
        je checkypos2
        inc edi
        inc edi
        jmp l3
        checkypos2:
        mov dx,[edi+1]
        cmp dl,yCoinPos
        je l1
        inc edi
        inc edi
        cmp bx,5
        jne l3

        draw2:

    mov al,xCoinPos
    mov fruitxpos,al
    mov al,yCoinPos
    mov fruitypos,al

    mov eax, cyan ; Set text color to yellow
    call SetTextColor
    mov dl, xCoinPos
    mov dh, yCoinPos
    call GoToxy
    mov al, '*'
    call WriteChar

ret
DrawFruit3 ENDP

fruitIntersection PROC

mov edx,0

        mov dl,fruitxpos
        cmp dl,xPos
        je checkyposgi
        jmp ext
        checkyposgi:
        mov dl,fruitypos
        cmp dl,yPos
        je incsc

        jmp ext

        incsc:
        mov eax,0
        mov ax, score
        add al,9
        mov score,ax
        mov fruitxpos,200
        mov fruitypos,200

        ext:

        ret 
fruitIntersection ENDP

DrawPortal3 PROC
mov ecx,2
mov esi,offset portal
l1:

    mov eax, lightblue; Set text color to yellow
    call SetTextColor
    mov dl, [esi]
    mov dh, [esi+1]
    call GoToxy
    mov al, '|'
    call WriteChar
    inc esi
    inc esi

    loop l1

    mov ecx,2
l2:

    mov eax, lightblue; Set text color to yellow
    call SetTextColor
    mov dl, [esi]
    mov dh, [esi+1]
    call GoToxy
    mov al, '-'
    call WriteChar
    inc esi
    inc esi

    loop l2

ret
DrawPortal3 ENDP

END main