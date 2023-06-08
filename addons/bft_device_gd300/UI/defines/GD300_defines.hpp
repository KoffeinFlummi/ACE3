#ifndef BFT_DEVICE_GD300_DEFINES_
#define BFT_DEVICE_GD300_DEFINES_
// Map position within background, pixel based
#define GD300_MAP_X (452)
#define GD300_MAP_Y (713)
#define GD300_MAP_W (1067)
#define GD300_MAP_H (622)

// Height of header and footer OSD elements
#define GD300_OSD_HEADER_H (60)
#define GD300_OSD_FOOTER_H (0)

// Screen content (the stuff that changes, so map area - header and footer)
#define GD300_SCREEN_CONTENT_X (GD300_MAP_X)
#define GD300_SCREEN_CONTENT_Y (GD300_MAP_Y + GD300_OSD_HEADER_H)
#define GD300_SCREEN_CONTENT_W (GD300_MAP_W)
#define GD300_SCREEN_CONTENT_H (GD300_MAP_H - GD300_OSD_HEADER_H - GD300_OSD_FOOTER_H)

// Message element positions in pixels
#define GD300_MESSAGE_MARGIN_OUTER (20)
#define GD300_MESSAGE_MARGIN_INNER (10)

#define GD300_MESSAGE_BUTTON_H (60)

#define GD300_MESSAGE_MESSAGETEXT_FRAME_X (GD300_MAP_X + GD300_MESSAGE_MARGIN_OUTER)
#define GD300_MESSAGE_MESSAGETEXT_FRAME_Y (GD300_MAP_Y + GD300_OSD_HEADER_H + GD300_MESSAGE_MARGIN_INNER)
#define GD300_MESSAGE_MESSAGETEXT_FRAME_W (GD300_MAP_W - GD300_MESSAGE_MARGIN_OUTER * 2)
#define GD300_MESSAGE_MESSAGETEXT_FRAME_H (GD300_MAP_H - GD300_OSD_HEADER_H - GD300_MESSAGE_MARGIN_INNER * 2)

#define GD300_MESSAGE_MESSAGELIST_X (GD300_MESSAGE_MESSAGETEXT_FRAME_X + GD300_MESSAGE_MARGIN_INNER)
#define GD300_MESSAGE_MESSAGELIST_Y (GD300_MESSAGE_MESSAGETEXT_FRAME_Y + GD300_MESSAGE_MARGIN_OUTER)
#define GD300_MESSAGE_MESSAGELIST_W ((GD300_MESSAGE_MESSAGETEXT_FRAME_W - GD300_MESSAGE_MARGIN_INNER * 3) / 3)
#define GD300_MESSAGE_MESSAGELIST_H (GD300_MESSAGE_MESSAGETEXT_FRAME_H - GD300_MESSAGE_MARGIN_INNER * 3 - GD300_MESSAGE_MARGIN_OUTER - GD300_MESSAGE_BUTTON_H * 2)

#define GD300_MESSAGE_MESSAGETEXT_X (GD300_MESSAGE_MESSAGELIST_X + GD300_MESSAGE_MESSAGELIST_W + GD300_MESSAGE_MARGIN_INNER)
#define GD300_MESSAGE_MESSAGETEXT_Y (GD300_MESSAGE_MESSAGELIST_Y)
#define GD300_MESSAGE_MESSAGETEXT_W (GD300_MESSAGE_MESSAGELIST_W * 2)
#define GD300_MESSAGE_MESSAGETEXT_H (GD300_MESSAGE_MESSAGETEXT_FRAME_H - GD300_MESSAGE_MARGIN_OUTER - GD300_MESSAGE_MARGIN_INNER)

#define GD300_MESSAGE_COMPOSE_FRAME_X (GD300_MESSAGE_MESSAGETEXT_FRAME_X)
#define GD300_MESSAGE_COMPOSE_FRAME_Y (GD300_MESSAGE_MESSAGETEXT_FRAME_Y)
#define GD300_MESSAGE_COMPOSE_FRAME_W (GD300_MESSAGE_MESSAGETEXT_FRAME_W)
#define GD300_MESSAGE_COMPOSE_FRAME_H (GD300_MESSAGE_MESSAGETEXT_FRAME_H)

#define GD300_MESSAGE_PLAYERLIST_X (GD300_MESSAGE_MESSAGELIST_X)
#define GD300_MESSAGE_PLAYERLIST_Y (GD300_MESSAGE_COMPOSE_FRAME_Y + GD300_MESSAGE_MARGIN_OUTER)
#define GD300_MESSAGE_PLAYERLIST_W (GD300_MESSAGE_MESSAGELIST_W)
#define GD300_MESSAGE_PLAYERLIST_H (GD300_MESSAGE_MESSAGELIST_H)

#define GD300_MESSAGE_COMPOSE_TEXT_X (GD300_MESSAGE_MESSAGETEXT_X)
#define GD300_MESSAGE_COMPOSE_TEXT_Y (GD300_MESSAGE_PLAYERLIST_Y)
#define GD300_MESSAGE_COMPOSE_TEXT_W (GD300_MESSAGE_MESSAGETEXT_W)
#define GD300_MESSAGE_COMPOSE_TEXT_H (GD300_MESSAGE_MESSAGETEXT_H)

#define GD300_MESSAGE_BUTTON_W (GD300_MESSAGE_MESSAGELIST_W)

#define GD300_MESSAGE_BUTTON_SEND_X (GD300_MESSAGE_COMPOSE_FRAME_X + GD300_MESSAGE_MARGIN_INNER)
#define GD300_MESSAGE_BUTTON_SEND_Y (GD300_MESSAGE_PLAYERLIST_Y + GD300_MESSAGE_PLAYERLIST_H + GD300_MESSAGE_MARGIN_INNER)

#define GD300_MESSAGE_BUTTON_DELETE_X (GD300_MESSAGE_BUTTON_SEND_X)
#define GD300_MESSAGE_BUTTON_DELETE_Y (GD300_MESSAGE_BUTTON_SEND_Y)

#define GD300_MESSAGE_BUTTON_MODE_X (GD300_MESSAGE_BUTTON_SEND_X)
#define GD300_MESSAGE_BUTTON_MODE_Y (GD300_MESSAGE_BUTTON_SEND_Y + GD300_MESSAGE_MARGIN_INNER + GD300_MESSAGE_BUTTON_H)

// On-screen edge positions (left, right, top, bottom)
#define GD300_OSD_MARGIN (20)
#define GD300_OSD_EDGE_L (GD300_OSD_MARGIN + GD300_MAP_X)
#define GD300_OSD_EDGE_R (-GD300_OSD_MARGIN + GD300_MAP_X + GD300_MAP_W)
#define GD300_OSD_EDGE_T (GD300_OSD_MARGIN + GD300_MAP_Y)
#define GD300_OSD_EDGE_B (-GD300_OSD_FOOTER_H + GD300_MAP_Y + GD300_MAP_H)

// On-screen element base width and height
#define GD300_OSD_ELEMENT_STD_W ((GD300_MAP_W - GD300_OSD_MARGIN * 6) / 5)
#define GD300_OSD_ELEMENT_STD_H (GD300_OSD_HEADER_H - GD300_OSD_MARGIN)

// On-screen element X-coord for left, center and right elements
#define GD300_OSD_X(ITEM) (GD300_OSD_EDGE_L + (GD300_OSD_MARGIN + GD300_OSD_ELEMENT_STD_W) * (ITEM - 1))

// On-screen text sizes, hight in pixels
// Standard text elements
#define GD300_OSD_TEXT_STD_SIZE (38)
#define GD300_OSD_ICON_STD_SIZE (42)

// On-screen map centre cursor
#define GD300_CURSOR (48)

// On-screen menu frame
#define GD300_OSD_MENU_W (GD300_SCREEN_CONTENT_W / 4)
#define GD300_OSD_MENU_H (GD300_SCREEN_CONTENT_H)
#define GD300_OSD_MENU_X (GD300_SCREEN_CONTENT_X + GD300_SCREEN_CONTENT_W - GD300_OSD_MENU_W)
#define GD300_OSD_MENU_Y (GD300_SCREEN_CONTENT_Y)

// On-screen menu elelements
#define GD300_OSD_MENU_MARGIN_W (GD300_OSD_MENU_W * 0.05)
#define GD300_OSD_MENU_MARGIN_H (GD300_OSD_MENU_H * 0.05)
#define GD300_OSD_MENU_ELEMENT_X (GD300_OSD_MENU_X + GD300_OSD_MENU_MARGIN_W)
#define GD300_OSD_MENU_ELEMENT_W (GD300_OSD_MENU_W - (GD300_OSD_MENU_MARGIN_W * 2))
#define GD300_OSD_MENU_ELEMENT_H ((GD300_OSD_MENU_H - GD300_OSD_MENU_MARGIN_H * 8) / 7)
#define GD300_OSD_MENU_ELEMENT_Y(ITEM) (GD300_OSD_MENU_Y + GD300_OSD_MENU_MARGIN_H + (GD300_OSD_MENU_ELEMENT_H + GD300_OSD_MENU_MARGIN_H) * (ITEM - 1))

// like to pxToGrou, just for the menu
#define pxToMenu_X(PIXEL) (((PIXEL) - GD300_OSD_MENU_X) / GUI_GRID_PX_W * GUI_GRID_W)
#define pxToMenu_Y(PIXEL) (((PIXEL) - GD300_OSD_MENU_Y) / GUI_GRID_PX_H * GUI_GRID_H)

#endif /* BFT_DEVICE_GD300_DEFINES_ */
