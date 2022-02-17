%define SYS_READ 0
%define SYS_WRITE  1
%define SYS_CLOSE 3
%define SYS_EXIT 60
%define SYS_OPEN 2
%define SYS_NANOSLEEP 35
%define SYS_RT_SIGACTION 13
%define SYS_RT_SIGRETURN 15
%define SYS_DUP2 33
%define SYS_GETCWD 79
%define SYS_SOCKET 41
%define SYS_CONNECT 42
%define SYS_ACCEPT 43
%define SYS_SEND 289
%define SYS_RECV 291

; Standard file decriptors
%define STDOUT 1
%define STDIN 2

; signal handling
%define sigaction_size 32
%define sigaction_handler_offset 0
%define sigaction_restore_offset 16
%define sigaction_flags_offset 8
%define SA_RESTORER 0x4000000

; socket programming
%define AF_INET 2
%define SOCK_STREAM 1
