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

int	ft_str_isnumeric(char *str)
{
	if (str == NULL)
		return (-2);
	if (*str == '\0')
		return (-1);
	while (*str)
	{
		if (*str < '0' || *str > '9')
			return (0);
		str++;
	}
	return (1);
}

void	send_bits(int s_pid, char c)
{
	int	bit;

	bit = -1;
	while (++bit < 8)
	{
		if (c & (1 << bit))
		{
			if (kill(s_pid, SIGUSR1) == -1)
			{
				write(2, "Sending message is failure.\n", 28);
				exit(EXIT_FAILURE);
			}
		}
		else
		{
			if (kill(s_pid, SIGUSR2) == -1)
			{
				write(2, "Sending message is failure.\n", 28);
				exit(EXIT_FAILURE);
			}
		}
		usleep(100);
	}
}

int	main(int argc, char **argv)
{
	int	s_pid;
	int	i;

	if (argc != 3 || ft_str_isnumeric(argv[1]) != 1)
	{
		write(1, "Wrong format.\n", 14);
		exit(EXIT_FAILURE);
	}
	s_pid = ft_atoi(argv[1]);
	i = -1;
	while (argv[2][++i] != '\0')
		send_bits(s_pid, argv[2][i]);
	send_bits(s_pid, '\n');
	return (0);
}
