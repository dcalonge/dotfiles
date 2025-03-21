/* Generated by wayland-scanner 1.23.0 */

#ifndef RIVER_STATUS_UNSTABLE_V1_CLIENT_PROTOCOL_H
#define RIVER_STATUS_UNSTABLE_V1_CLIENT_PROTOCOL_H

#include <stdint.h>
#include <stddef.h>
#include "wayland-client.h"

#ifdef  __cplusplus
extern "C" {
#endif

/**
 * @page page_river_status_unstable_v1 The river_status_unstable_v1 protocol
 * @section page_ifaces_river_status_unstable_v1 Interfaces
 * - @subpage page_iface_zriver_status_manager_v1 - manage river status objects
 * - @subpage page_iface_zriver_output_status_v1 - track output tags and focus
 * - @subpage page_iface_zriver_seat_status_v1 - track seat focus
 * @section page_copyright_river_status_unstable_v1 Copyright
 * <pre>
 *
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
 * </pre>
 */
struct wl_output;
struct wl_seat;
struct zriver_output_status_v1;
struct zriver_seat_status_v1;
struct zriver_status_manager_v1;

#ifndef ZRIVER_STATUS_MANAGER_V1_INTERFACE
#define ZRIVER_STATUS_MANAGER_V1_INTERFACE
/**
 * @page page_iface_zriver_status_manager_v1 zriver_status_manager_v1
 * @section page_iface_zriver_status_manager_v1_desc Description
 *
 * A global factory for objects that receive status information specific
 * to river. It could be used to implement, for example, a status bar.
 * @section page_iface_zriver_status_manager_v1_api API
 * See @ref iface_zriver_status_manager_v1.
 */
/**
 * @defgroup iface_zriver_status_manager_v1 The zriver_status_manager_v1 interface
 *
 * A global factory for objects that receive status information specific
 * to river. It could be used to implement, for example, a status bar.
 */
extern const struct wl_interface zriver_status_manager_v1_interface;
#endif
#ifndef ZRIVER_OUTPUT_STATUS_V1_INTERFACE
#define ZRIVER_OUTPUT_STATUS_V1_INTERFACE
/**
 * @page page_iface_zriver_output_status_v1 zriver_output_status_v1
 * @section page_iface_zriver_output_status_v1_desc Description
 *
 * This interface allows clients to receive information about the current
 * windowing state of an output.
 * @section page_iface_zriver_output_status_v1_api API
 * See @ref iface_zriver_output_status_v1.
 */
/**
 * @defgroup iface_zriver_output_status_v1 The zriver_output_status_v1 interface
 *
 * This interface allows clients to receive information about the current
 * windowing state of an output.
 */
extern const struct wl_interface zriver_output_status_v1_interface;
#endif
#ifndef ZRIVER_SEAT_STATUS_V1_INTERFACE
#define ZRIVER_SEAT_STATUS_V1_INTERFACE
/**
 * @page page_iface_zriver_seat_status_v1 zriver_seat_status_v1
 * @section page_iface_zriver_seat_status_v1_desc Description
 *
 * This interface allows clients to receive information about the current
 * focus of a seat. Note that (un)focused_output events will only be sent
 * if the client has bound the relevant wl_output globals.
 * @section page_iface_zriver_seat_status_v1_api API
 * See @ref iface_zriver_seat_status_v1.
 */
/**
 * @defgroup iface_zriver_seat_status_v1 The zriver_seat_status_v1 interface
 *
 * This interface allows clients to receive information about the current
 * focus of a seat. Note that (un)focused_output events will only be sent
 * if the client has bound the relevant wl_output globals.
 */
extern const struct wl_interface zriver_seat_status_v1_interface;
#endif

#define ZRIVER_STATUS_MANAGER_V1_DESTROY 0
#define ZRIVER_STATUS_MANAGER_V1_GET_RIVER_OUTPUT_STATUS 1
#define ZRIVER_STATUS_MANAGER_V1_GET_RIVER_SEAT_STATUS 2


/**
 * @ingroup iface_zriver_status_manager_v1
 */
#define ZRIVER_STATUS_MANAGER_V1_DESTROY_SINCE_VERSION 1
/**
 * @ingroup iface_zriver_status_manager_v1
 */
#define ZRIVER_STATUS_MANAGER_V1_GET_RIVER_OUTPUT_STATUS_SINCE_VERSION 1
/**
 * @ingroup iface_zriver_status_manager_v1
 */
#define ZRIVER_STATUS_MANAGER_V1_GET_RIVER_SEAT_STATUS_SINCE_VERSION 1

/** @ingroup iface_zriver_status_manager_v1 */
static inline void
zriver_status_manager_v1_set_user_data(struct zriver_status_manager_v1 *zriver_status_manager_v1, void *user_data)
{
	wl_proxy_set_user_data((struct wl_proxy *) zriver_status_manager_v1, user_data);
}

/** @ingroup iface_zriver_status_manager_v1 */
static inline void *
zriver_status_manager_v1_get_user_data(struct zriver_status_manager_v1 *zriver_status_manager_v1)
{
	return wl_proxy_get_user_data((struct wl_proxy *) zriver_status_manager_v1);
}

static inline uint32_t
zriver_status_manager_v1_get_version(struct zriver_status_manager_v1 *zriver_status_manager_v1)
{
	return wl_proxy_get_version((struct wl_proxy *) zriver_status_manager_v1);
}

/**
 * @ingroup iface_zriver_status_manager_v1
 *
 * This request indicates that the client will not use the
 * river_status_manager object any more. Objects that have been created
 * through this instance are not affected.
 */
static inline void
zriver_status_manager_v1_destroy(struct zriver_status_manager_v1 *zriver_status_manager_v1)
{
	wl_proxy_marshal_flags((struct wl_proxy *) zriver_status_manager_v1,
			 ZRIVER_STATUS_MANAGER_V1_DESTROY, NULL, wl_proxy_get_version((struct wl_proxy *) zriver_status_manager_v1), WL_MARSHAL_FLAG_DESTROY);
}

/**
 * @ingroup iface_zriver_status_manager_v1
 *
 * This creates a new river_output_status object for the given wl_output.
 */
static inline struct zriver_output_status_v1 *
zriver_status_manager_v1_get_river_output_status(struct zriver_status_manager_v1 *zriver_status_manager_v1, struct wl_output *output)
{
	struct wl_proxy *id;

	id = wl_proxy_marshal_flags((struct wl_proxy *) zriver_status_manager_v1,
			 ZRIVER_STATUS_MANAGER_V1_GET_RIVER_OUTPUT_STATUS, &zriver_output_status_v1_interface, wl_proxy_get_version((struct wl_proxy *) zriver_status_manager_v1), 0, NULL, output);

	return (struct zriver_output_status_v1 *) id;
}

/**
 * @ingroup iface_zriver_status_manager_v1
 *
 * This creates a new river_seat_status object for the given wl_seat.
 */
static inline struct zriver_seat_status_v1 *
zriver_status_manager_v1_get_river_seat_status(struct zriver_status_manager_v1 *zriver_status_manager_v1, struct wl_seat *seat)
{
	struct wl_proxy *id;

	id = wl_proxy_marshal_flags((struct wl_proxy *) zriver_status_manager_v1,
			 ZRIVER_STATUS_MANAGER_V1_GET_RIVER_SEAT_STATUS, &zriver_seat_status_v1_interface, wl_proxy_get_version((struct wl_proxy *) zriver_status_manager_v1), 0, NULL, seat);

	return (struct zriver_seat_status_v1 *) id;
}

/**
 * @ingroup iface_zriver_output_status_v1
 * @struct zriver_output_status_v1_listener
 */
struct zriver_output_status_v1_listener {
	/**
	 * focused tags of the output
	 *
	 * Sent once binding the interface and again whenever the tag
	 * focus of the output changes.
	 * @param tags 32-bit bitfield
	 */
	void (*focused_tags)(void *data,
			     struct zriver_output_status_v1 *zriver_output_status_v1,
			     uint32_t tags);
	/**
	 * tag state of an output's views
	 *
	 * Sent once on binding the interface and again whenever the tag
	 * state of the output changes.
	 * @param tags array of 32-bit bitfields
	 */
	void (*view_tags)(void *data,
			  struct zriver_output_status_v1 *zriver_output_status_v1,
			  struct wl_array *tags);
	/**
	 * tags of the output with an urgent view
	 *
	 * Sent once on binding the interface and again whenever the set
	 * of tags with at least one urgent view changes.
	 * @param tags 32-bit bitfield
	 * @since 2
	 */
	void (*urgent_tags)(void *data,
			    struct zriver_output_status_v1 *zriver_output_status_v1,
			    uint32_t tags);
	/**
	 * name of the layout
	 *
	 * Sent once on binding the interface should a layout name exist
	 * and again whenever the name changes.
	 * @param name layout name
	 * @since 4
	 */
	void (*layout_name)(void *data,
			    struct zriver_output_status_v1 *zriver_output_status_v1,
			    const char *name);
	/**
	 * name of the layout
	 *
	 * Sent when the current layout name has been removed without a
	 * new one being set, for example when the active layout generator
	 * disconnects.
	 * @since 4
	 */
	void (*layout_name_clear)(void *data,
				  struct zriver_output_status_v1 *zriver_output_status_v1);
};

/**
 * @ingroup iface_zriver_output_status_v1
 */
static inline int
zriver_output_status_v1_add_listener(struct zriver_output_status_v1 *zriver_output_status_v1,
				     const struct zriver_output_status_v1_listener *listener, void *data)
{
	return wl_proxy_add_listener((struct wl_proxy *) zriver_output_status_v1,
				     (void (**)(void)) listener, data);
}

#define ZRIVER_OUTPUT_STATUS_V1_DESTROY 0

/**
 * @ingroup iface_zriver_output_status_v1
 */
#define ZRIVER_OUTPUT_STATUS_V1_FOCUSED_TAGS_SINCE_VERSION 1
/**
 * @ingroup iface_zriver_output_status_v1
 */
#define ZRIVER_OUTPUT_STATUS_V1_VIEW_TAGS_SINCE_VERSION 1
/**
 * @ingroup iface_zriver_output_status_v1
 */
#define ZRIVER_OUTPUT_STATUS_V1_URGENT_TAGS_SINCE_VERSION 2
/**
 * @ingroup iface_zriver_output_status_v1
 */
#define ZRIVER_OUTPUT_STATUS_V1_LAYOUT_NAME_SINCE_VERSION 4
/**
 * @ingroup iface_zriver_output_status_v1
 */
#define ZRIVER_OUTPUT_STATUS_V1_LAYOUT_NAME_CLEAR_SINCE_VERSION 4

/**
 * @ingroup iface_zriver_output_status_v1
 */
#define ZRIVER_OUTPUT_STATUS_V1_DESTROY_SINCE_VERSION 1

/** @ingroup iface_zriver_output_status_v1 */
static inline void
zriver_output_status_v1_set_user_data(struct zriver_output_status_v1 *zriver_output_status_v1, void *user_data)
{
	wl_proxy_set_user_data((struct wl_proxy *) zriver_output_status_v1, user_data);
}

/** @ingroup iface_zriver_output_status_v1 */
static inline void *
zriver_output_status_v1_get_user_data(struct zriver_output_status_v1 *zriver_output_status_v1)
{
	return wl_proxy_get_user_data((struct wl_proxy *) zriver_output_status_v1);
}

static inline uint32_t
zriver_output_status_v1_get_version(struct zriver_output_status_v1 *zriver_output_status_v1)
{
	return wl_proxy_get_version((struct wl_proxy *) zriver_output_status_v1);
}

/**
 * @ingroup iface_zriver_output_status_v1
 *
 * This request indicates that the client will not use the
 * river_output_status object any more.
 */
static inline void
zriver_output_status_v1_destroy(struct zriver_output_status_v1 *zriver_output_status_v1)
{
	wl_proxy_marshal_flags((struct wl_proxy *) zriver_output_status_v1,
			 ZRIVER_OUTPUT_STATUS_V1_DESTROY, NULL, wl_proxy_get_version((struct wl_proxy *) zriver_output_status_v1), WL_MARSHAL_FLAG_DESTROY);
}

/**
 * @ingroup iface_zriver_seat_status_v1
 * @struct zriver_seat_status_v1_listener
 */
struct zriver_seat_status_v1_listener {
	/**
	 * the seat focused an output
	 *
	 * Sent on binding the interface and again whenever an output
	 * gains focus.
	 */
	void (*focused_output)(void *data,
			       struct zriver_seat_status_v1 *zriver_seat_status_v1,
			       struct wl_output *output);
	/**
	 * the seat unfocused an output
	 *
	 * Sent whenever an output loses focus.
	 */
	void (*unfocused_output)(void *data,
				 struct zriver_seat_status_v1 *zriver_seat_status_v1,
				 struct wl_output *output);
	/**
	 * information on the focused view
	 *
	 * Sent once on binding the interface and again whenever the
	 * focused view or a property thereof changes. The title may be an
	 * empty string if no view is focused or the focused view did not
	 * set a title.
	 * @param title title of the focused view
	 */
	void (*focused_view)(void *data,
			     struct zriver_seat_status_v1 *zriver_seat_status_v1,
			     const char *title);
	/**
	 * the active mode changed
	 *
	 * Sent once on binding the interface and again whenever a new
	 * mode is entered (e.g. with riverctl enter-mode foobar).
	 * @param name name of the mode
	 * @since 3
	 */
	void (*mode)(void *data,
		     struct zriver_seat_status_v1 *zriver_seat_status_v1,
		     const char *name);
};

/**
 * @ingroup iface_zriver_seat_status_v1
 */
static inline int
zriver_seat_status_v1_add_listener(struct zriver_seat_status_v1 *zriver_seat_status_v1,
				   const struct zriver_seat_status_v1_listener *listener, void *data)
{
	return wl_proxy_add_listener((struct wl_proxy *) zriver_seat_status_v1,
				     (void (**)(void)) listener, data);
}

#define ZRIVER_SEAT_STATUS_V1_DESTROY 0

/**
 * @ingroup iface_zriver_seat_status_v1
 */
#define ZRIVER_SEAT_STATUS_V1_FOCUSED_OUTPUT_SINCE_VERSION 1
/**
 * @ingroup iface_zriver_seat_status_v1
 */
#define ZRIVER_SEAT_STATUS_V1_UNFOCUSED_OUTPUT_SINCE_VERSION 1
/**
 * @ingroup iface_zriver_seat_status_v1
 */
#define ZRIVER_SEAT_STATUS_V1_FOCUSED_VIEW_SINCE_VERSION 1
/**
 * @ingroup iface_zriver_seat_status_v1
 */
#define ZRIVER_SEAT_STATUS_V1_MODE_SINCE_VERSION 3

/**
 * @ingroup iface_zriver_seat_status_v1
 */
#define ZRIVER_SEAT_STATUS_V1_DESTROY_SINCE_VERSION 1

/** @ingroup iface_zriver_seat_status_v1 */
static inline void
zriver_seat_status_v1_set_user_data(struct zriver_seat_status_v1 *zriver_seat_status_v1, void *user_data)
{
	wl_proxy_set_user_data((struct wl_proxy *) zriver_seat_status_v1, user_data);
}

/** @ingroup iface_zriver_seat_status_v1 */
static inline void *
zriver_seat_status_v1_get_user_data(struct zriver_seat_status_v1 *zriver_seat_status_v1)
{
	return wl_proxy_get_user_data((struct wl_proxy *) zriver_seat_status_v1);
}

static inline uint32_t
zriver_seat_status_v1_get_version(struct zriver_seat_status_v1 *zriver_seat_status_v1)
{
	return wl_proxy_get_version((struct wl_proxy *) zriver_seat_status_v1);
}

/**
 * @ingroup iface_zriver_seat_status_v1
 *
 * This request indicates that the client will not use the
 * river_seat_status object any more.
 */
static inline void
zriver_seat_status_v1_destroy(struct zriver_seat_status_v1 *zriver_seat_status_v1)
{
	wl_proxy_marshal_flags((struct wl_proxy *) zriver_seat_status_v1,
			 ZRIVER_SEAT_STATUS_V1_DESTROY, NULL, wl_proxy_get_version((struct wl_proxy *) zriver_seat_status_v1), WL_MARSHAL_FLAG_DESTROY);
}

#ifdef  __cplusplus
}
#endif

#endif
