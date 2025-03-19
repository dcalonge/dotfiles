/* Generated by wayland-scanner 1.23.0 */

/*
 * Copyright 2020 The River Developers
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

#include <stdbool.h>
#include <stdlib.h>
#include <stdint.h>
#include "wayland-util.h"

#ifndef __has_attribute
# define __has_attribute(x) 0  /* Compatibility with non-clang compilers. */
#endif

#if (__has_attribute(visibility) || defined(__GNUC__) && __GNUC__ >= 4)
#define WL_PRIVATE __attribute__ ((visibility("hidden")))
#else
#define WL_PRIVATE
#endif

extern const struct wl_interface wl_seat_interface;
extern const struct wl_interface zriver_command_callback_v1_interface;

static const struct wl_interface *river_control_unstable_v1_types[] = {
	NULL,
	&wl_seat_interface,
	&zriver_command_callback_v1_interface,
};

static const struct wl_message zriver_control_v1_requests[] = {
	{ "destroy", "", river_control_unstable_v1_types + 0 },
	{ "add_argument", "s", river_control_unstable_v1_types + 0 },
	{ "run_command", "on", river_control_unstable_v1_types + 1 },
};

WL_PRIVATE const struct wl_interface zriver_control_v1_interface = {
	"zriver_control_v1", 1,
	3, zriver_control_v1_requests,
	0, NULL,
};

static const struct wl_message zriver_command_callback_v1_events[] = {
	{ "success", "s", river_control_unstable_v1_types + 0 },
	{ "failure", "s", river_control_unstable_v1_types + 0 },
};

WL_PRIVATE const struct wl_interface zriver_command_callback_v1_interface = {
	"zriver_command_callback_v1", 1,
	0, NULL,
	2, zriver_command_callback_v1_events,
};

