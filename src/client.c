/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: retanaka <retanaka@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/06/24 22:17:32 by retanaka          #+#    #+#             */
/*   Updated: 2024/06/24 22:57:47 by retanaka         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"
#include "libft.h"

void	send_bits(int pid, char c)
{
	int	bit;

	bit = -1;
	while (++bit < 8)
	{
		if (c & (1 << bit))
			kill(pid, SIGUSR1);
		else
			kill(pid, SIGUSR2);
		usleep(100);
	}
}

int	main(int argc, char **argv)
{
	int	pid;
	int	i;

	if (argc != 3)
		return (write(1, "Wrong format.\n", 14), 0);
	pid = ft_atoi(argv[1]);
	i = -1;
	while (argv[2][++i] != '\0')
		send_bits(pid, argv[2][i]);
	send_bits(pid, '\n');
	return (0);
}
