/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: retanaka <retanaka@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/06/24 22:17:58 by retanaka          #+#    #+#             */
/*   Updated: 2024/06/24 22:42:57 by retanaka         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"

void	get_signal(int sig, siginfo_t *info, void *context)
{
	static int	bit;
	static char	c;

	(void)context;
	(void)info;
	if (sig == SIGUSR1)
		c |= (1 << bit);
	bit++;
	if (bit == 8)
	{
		write(1, &c, 1);
		bit = 0;
		c = 0;
	}
}

int	main(void)
{
	int					pid;
	struct sigaction	sa;
	sigset_t			block_mask;
	char				*num_str;

	sigemptyset(&block_mask);
	sigaddset(&block_mask, SIGINT);
	sigaddset(&block_mask, SIGQUIT);
	pid = getpid();
	write(1, "PID: ", 5);
	num_str = ft_itoa(pid);
	write(1, "\n", 1);
	free(num_str);
	sa.sa_sigaction = &get_signal;
	sa.sa_flags = SA_SIGINFO;
	sa.sa_mask = block_mask;
	sigaction(SIGUSR1, &sa, NULL);
	sigaction(SIGUSR2, &sa, NULL);
	while (1)
		pause ();
	return (0);
}
