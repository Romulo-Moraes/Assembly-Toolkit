%define SYS_READ_X64 0
%define SYS_WRITE_X64  1
%define SYS_CLOSE_X64 3
%define SYS_EXIT_X64 60
%define SYS_OPEN_X64 2
%define SYS_GETCWD_X64 79
%define SYS_NANOSLEEP_X64 35
%define SYS_RT_SIGACTION_X64 13
%define SYS_RT_SIGRETURN_X64 15
%define SYS_DUP2_X64 33
%define SYS_GETCWD_X64 79
%define SYS_SOCKET_X64 41
%define SYS_CONNECT_X64 42
%define SYS_ACCEPT_X64 43
%define SYS_SEND_X64 289
%define SYS_RECV_X64 291

%define SYS_WRITE_X32 4
%define SYS_EXIT_X32 1
%define SYS_READ_X32 3
%define SYS_CLOSE_X32 6
%define SYS_OPEN_X32 5
%define SYS_CHDIR_X32 12
%define SYS_GETCWD_X32 183

; Standard file decriptors
%define STDOUT 1
%define STDIN 2

; Exit status
%define EXIT_SUCCESS 0
%define EXIT_FAILURE 1






; signal handling
%define sigaction_size 32
%define sigaction_handler_offset 0
%define sigaction_restore_offset 16
%define sigaction_flags_offset 8
%define SA_RESTORER 0x4000000

; socket programming
%define AF_INET 2
%define SOCK_STREAM 1