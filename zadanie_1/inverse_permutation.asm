global inverse_permutation

section .text

inverse_permutation:
                                         ;Część 1 – sprawdzenie czy n jest w
                                         ;przedziale [1, INT_MAX + 1].
        cmp     rdi, 0x0
        je      .return_false            ;Dla n = 0 od razu zwracamy false.
        mov     r9d, 0x80000000          ;Wartość tryzmana w rejestrze r9d to
                                         ;2^{31}, czyli INT_MAX + 1.
        cmp     rdi, r9
        jg      .return_false            ;Dla n > INT_MAX + 1 również możemy od
                                         ;razu zwrócić false.
        
                                         ;Część 2 – sprawdzenie czy elementy
                                         ;tablicy p są w przedziale [0, n - 1].
        xor     edx, edx                 ;Zmienna i służąca do iterowania się po
                                         ;tablicy p, początkowo równa 0.
.check_range_loop:
        mov     eax, [rsi + rdx * 4]     ;Wartość p[i];
        cmp     rax, rdi
        jge     .return_false            ;Jeżeli p[i] >= n, to zwracamy false.
                                         ;Sprawdzenie czy p[i] < 0 nie jest
                                         ;konieczne.
        
        inc     edx
        cmp     edx, edi
        jne     .check_range_loop        ;Jeżeli i != n, to kontynuujemy pętlę.
        
                                         ;Część 3 – sprawdzenie czy ciąg
                                         ;zapisany w tablicy p jest permutacją
                                         ;zbioru {0, ..., n - 1}.
        xor     edx, edx                 ;Zmienna i – tak jak poprzednio.
.check_permutation_loop:
        test    [rsi + rdx * 4], r9d     ;Sprawdzenie czy p[i] < 0.
        jnz     .skip_cycle_loop         ;Jeżeli p[i] < 0, to i odwiedzone.
        
        mov     ecx, edx                 ;Zmienna j służąca do iterowania się po
                                         ;kolejnych wartościach i, p[i],
                                         ;p[p[i]], p[p[p[i]]]...
.cycle_loop:
        mov     eax, [rsi + rcx * 4]     ;Wartość p[j].
        test    eax, r9d                 ;Sprawdzenie czy p[j] < 0.
        jnz     .clear_table             ;Jeżeli p[j] < 0, to j odwiedzone,
                                         ;czyli ciąg nie jest permutacją.
        
        xor     [rsi + rcx * 4], r9d     ;Zaznaczamy, że j jest odwiedzone,
                                         ;zmieniając bit znaku komórce p[j].
        mov     ecx, eax                 ;Przechodzimy z j do p[j].
        cmp     ecx, edx
        jne     .cycle_loop              ;Pętla dopóki j != i, czyli dopóki nie
                                         ;wrócimy do początku cyklu.
        
.skip_cycle_loop:
        inc     edx
        cmp     edx, edi
        jne     .check_permutation_loop  ;Jeżeli i != n, to kontynuujemy pętlę.
        
                                         ;Część 4 – odwrócenie permutacji. W tym
                                         ;momencie wszystkie p[i] mają ustawiony
                                         ;bit znaku na 1.
        xor     edx, edx                 ;Zmienna i – tak jak poprzednio.
.invert_permutation_loop:
        test    [rsi + rdx * 4], r9d
        jz      .skip_invert_cycle_loop  ;Jeżeli p[i] >= 0, to element ten był
                                         ;już na jakimś wcześniejszym cyklu.
        
        mov     ecx, [rsi + rdx * 4]     ;Wartość zmiennej j ustawiamy na p[i] z
                                         ;odwróconym bitem znaku.
        xor     ecx, r9d                 ;Ustawiamy bit znaku z powrotem na 0.
        mov     r8d, edx                 ;r8d to poprzedni element, najpierw i.
.invert_cycle_loop:
        mov     eax, [rsi + rcx * 4]     ;W rejestrze eax zapisujemy wartość
                                         ;p[j] z odwróconym bitem znaku.
        xor     eax, r9d                 ;Ustawiamy bit znaku z powrotem na 0.
        mov     [rsi + rcx * 4], r8d     ;Ustawiamy p[j] na poprzedni.
        mov     r8d, ecx                 ;Poprzedni ustawiamy na j.
        mov     ecx, eax                 ;j ustawiamy na następny, czyli p[j]
                                         ;(przed ustawieniem na poprzedni).
        cmp     ecx, edx
        jne     .invert_cycle_loop       ;Pętla dopóki j != i.
        
        mov     [rsi + rdx * 4], r8d     ;Ustawiamy p[i] na poprzedni.
        
.skip_invert_cycle_loop:
        inc     edx
        cmp     edx, edi
        jne     .invert_permutation_loop ;Jeżeli i != n, to kontynuujemy pętlę.
        
.return_true:
        mov     al, 0x1
        ret
        
.clear_table:
        xor     edx, edx                 ;Zmienna i – tak jak poprzednio.
        dec     r9d                      ;Od teraz w r9d mamy 2^{31} - 1.
.clear_table_loop:
        and     [rsi + rdx * 4], r9d     ;Jeżeli p[i] < 0, to ustawiamy bit
                                         ;znaku z powrotem na 0.
        inc     edx
        cmp     edx, edi
        jne     .clear_table_loop        ;Jeżeli i != n, to kontynuujemy pętlę.
        
.return_false:
        xor     al, al
        ret
