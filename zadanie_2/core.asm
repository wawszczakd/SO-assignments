global core

extern get_value, put_value

section .data

waiting times N dq N                     ;Tablica do sygnalizowania czekania.
value   times N dq 0                     ;Tablica do przekazania wartości.

section .text

core:
        push    r12                      ;Wrzucamy r12 i r13 na stos, żeby
        push    r13                      ;na koniec je odzyskać.
        mov     r12, rsp                 ;W r12 zapisujemy rsp, aby na koniec
                                         ;go odzyskać.
        
        xor     rdx, rdx                 ;Zmienna i służąca do iterowania się po
                                         ;napisie, początkowo równa 0.
.text_size_loop:
        mov     cl, [rsi + rdx]          ;W cl zapisujemy i-ty znak napisu.
        cmp     cl, 0                    ;Jeśli i-ty znak napisu to '\0',
        je      .finish                  ;wychodzimy z pętli.
        
        cmp     cl, '+'                  ;Przypadek 1 – '+'
        jne     .skip_plus
        pop     r8                       ;W r8 zapisujemy wartość na szczycie
        pop     r9                       ;stosu, a w r9 wartość pod nią.
        add     r8, r9
        push    r8                       ;Wrzucamy na stos ich sumę.
.skip_plus:
        
        cmp     cl, '*'                  ;Przypadek 2 – '*'
        jne     .skip_asterisk
        pop     r8                       ;W r8 zapisujemy wartość na szczycie
        pop     r9                       ;stosu, a w r9 wartość pod nią.
        imul    r8, r9
        push    r8                       ;Wrzucamy na stos ich iloczyn.
.skip_asterisk:
        
        cmp     cl, '-'                  ;Przypadek 3 – '-'
        jne     .skip_minus
        pop     r8                       ;W r8 zapisujemy wartość na szczycie
        neg     r8                       ;stosu, a następnie ją negujemy.
        push    r8                       ;Wrzucamy na stos zanegowaną wartość.
.skip_minus:
        
        cmp     cl, '0'                  ;Przypadek 4 – '0', '1', '2' ... '9'
        jl      .skip_digit
        cmp     cl, '9'
        jg      .skip_digit
        movzx   r8, cl                   ;W r8 zapisujemy kod ASCII cyfry.
        sub     r8, '0'                  ;Rzeczywista wartość cyfry.
        push    r8                       ;Wrzucamy na stos wartość cyfry.
.skip_digit:
        
        cmp     cl, 'n'                  ;Przypadek 5 – 'n'
        jne     .skip_n
        push    rdi                      ;Wrzucamy na stos numer rdzenia.
.skip_n:
        
        cmp     cl, 'B'                  ;Przypadek 6 – 'B'
        jne     .skip_B
        pop     r8                       ;W r8 zapisujemy wartość na szczycie
        cmp     qword [rsp], 0           ;stosu, po czym sprawdzamy czy na
        je      .skip_B                  ;stosie jest niezerowa wartość.
        add     rdx, r8                  ;Zwiększamy i o odpowiednią liczbę.
.skip_B:
        
        cmp     cl, 'C'                  ;Przypadek 7 – 'C'
        jne     .skip_C
        pop     r8                       ;Zdejmujemy wartość ze szytu stosu.
.skip_C:
        
        cmp     cl, 'D'                  ;Przypadek 8 – 'D'
        jne     .skip_D
        pop     r8                       ;W r8 zapisujemy wartość na szycie
        push    r8                       ;stosu, po czym wrzucamy ją z powrotem
        push    r8                       ;wrzucamy ją dwa razy na stos.
.skip_D:
        
        cmp     cl, 'E'                  ;Przypadek 9 – 'E'
        jne     .skip_E
        pop     r8                       ;W r8 zapisujemy wartość na szczycie
        pop     r9                       ;stosu, a w r9 wartość pod nią.
        push    r8                       ;Wrzucamy je z powrotem na stos w
        push    r9                       ;odpowiedniej kolejności.
.skip_E:
        
        cmp     cl, 'G'                  ;Przypadek 10 – 'G'
        jne     .skip_G
        
        push    rdi                      ;Wrzucamy na stos istotne dla nas
        push    rsi                      ;rejestry, aby po wywołaniu funkcji
        push    rdx                      ;odzyskać ich wartości.
        push    rcx
        mov     r13, rsp
        
        and     rsp, -16                 ;Wyrównujemy stos.
        call    get_value                ;Wywołujemy funkcję get_value.
        
        mov     rsp, r13                 ;Przywracamy rejestry.
        pop     rcx
        pop     rdx
        pop     rsi
        pop     rdi
        
        push    rax                      ;Wrzucamy na stos wynik funkcji.
.skip_G:
        
        cmp     cl, 'P'                  ;Przypadek 11 – 'P'
        jne     .skip_P
        
        pop     r8                       ;W r8 zapisujemy wartość na szycie
                                         ;stosu (w treści oznaczona przez w).
        push    rdi                      ;Wrzucamy na stos istotne dla nas
        push    rsi                      ;rejestry, aby po wywołaniu funkcji
        push    rdx                      ;odzyskać ich wartości.
        push    rcx
        mov     r13, rsp
        
        and     rsp, -16                 ;Wyrównujemy stos.
        mov     rsi, r8                  ;Ustawiamy w jako drugi parametr.
        call    put_value                ;Wywołujemy funkcję put_value.
        
        mov     rsp, r13                 ;Przywracamy rejestry.
        pop     rcx
        pop     rdx
        pop     rsi
        pop     rdi
.skip_P:
        
        cmp     cl, 'S'                  ;Przypadek 12 – 'S'
        jne     .skip_S
        
        lea     r8, [rel waiting]
        lea     r9, [rel value]
        
        pop     rax                      ;Numer rdzenia, na który czekamy.
        pop     r10                      ;Wartość do wymiany.
        
        mov     [r9 + 8 * rdi], r10      ;Kolejność tutaj jest istotna.
        mov     [r8 + 8 * rdi], rax
        
.wait_for_core_loop:
        mov     r11, [r8 + 8 * rax]
        cmp     r11, rdi                 ;Sprawdzamy czy rdzeń, na którego
        jne     .wait_for_core_loop      ;czekamy, czeka na nas.
        
        push    qword [r9 + 8 * rax]     ;Wrzucamy na stos wymienioną wartość.
        
        mov     qword [r8 + 8 * rax], N  ;Zaznaczamy, że już na nikogo nie
                                         ;czekamy.
.wait_for_value_loop:
        mov     r11, [r8 + 8 * rdi]      ;Sprawdzamy, czy wartość do wymiany
        cmp     r11, N                   ;została już odebrana.
        jne     .wait_for_value_loop
.skip_S:
        
        inc     rdx                      ;Zwiększamy wartość zmiennej i.
        jmp     .text_size_loop          ;Wracamy na początek pętli.
        
.finish:
        pop     rax                      ;Wynik to wartość na szycie stosu.
        mov     rsp, r12                 ;Przywracamy rejestry.
        pop     r13
        pop     r12
        ret
