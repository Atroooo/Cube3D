/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   create_textures_img.c                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: gclement <gclement@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/06/07 09:29:35 by gclement          #+#    #+#             */
/*   Updated: 2023/06/24 11:27:49 by gclement         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "cub3D.h"

t_img	create_textures_img(char *path, t_windows *win)
{
	t_img	data;
	int		fd;

	fd = open(path, O_RDONLY);
	if (fd < 0)
	{
		printf("Error with textures : %s\n", path);
		exit (0);
	}
	else
		close(fd);
	data.img = mlx_xpm_file_to_image(win->mlx, path, &data.width, &data.height);
	data.addr = mlx_get_data_addr(\
		data.img, &data.bits_per_pixel, \
		&data.line_length, &data.endian);
	return (data);
}

void	create_all_textures_img(t_env *env)
{
	if (open(env->data.no, O_RDONLY) < 0 || open(env->data.ea, O_RDONLY) < 0
		|| open(env->data.so, O_RDONLY) < 0 || open(env->data.we, O_RDONLY) < 0)
	{
		perror("textures");
		free_windows_struct(env);
	}
	env->data.textures_img[0] = create_textures_img(\
		env->data.no, &env->windows);
	env->data.textures_img[1] = create_textures_img(\
		env->data.ea, &env->windows);
	env->data.textures_img[2] = create_textures_img(\
		env->data.so, &env->windows);
	env->data.textures_img[3] = create_textures_img(\
		env->data.we, &env->windows);
	env->data.textures_img[4] = create_textures_img(\
		"./textures/door.xpm", &env->windows);
	env->data.sprites_img[0] = create_textures_img(\
		"./textures/pompe.xpm", &env->windows);
	env->data.sprites_img[1] = create_textures_img(\
		"./textures/pompe_shoot.xpm", &env->windows);
	env->data.data_opp.sprite_data.sprite = create_textures_img(\
		"./textures/alien_spritesheet.xpm", &env->windows);
}
