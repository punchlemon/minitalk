/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_strdup.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: retanaka <retanaka@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/04/18 15:42:53 by retanaka          #+#    #+#             */
/*   Updated: 2024/04/23 07:43:02 by retanaka         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft.h"

size_t	ft_strlen(const char *s)
{
	size_t		i;

	i = -1;
	while (*(s + ++i))
		;
	return (i);
}

size_t	ft_strlcpy(char *dst, const char *src, size_t dstsize)
{
	size_t	src_len;

	src_len = -1;
	while (*(src + ++src_len))
		;
	if (dstsize == 0)
		return (src_len);
	if (dstsize > src_len + 1)
		dstsize = src_len + 1;
	*(char *)(dst + dstsize - 1) = 0;
	while (--dstsize)
		*(char *)(dst + dstsize - 1) = *(char *)(src + dstsize - 1);
	return (src_len);
}

char	*ft_strdup(const char *s1)
{
	int		len;
	char	*p;

	len = ft_strlen(s1) + 1;
	p = (char *)malloc(len * sizeof(char));
	if (p != NULL)
		ft_strlcpy(p, s1, len);
	return (p);
}
