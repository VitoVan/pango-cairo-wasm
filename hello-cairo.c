/*
the following file is
copied and modified from:
https://github.com/tsuu32/sdl2-cairo-example/blob/master/sdl2-cairo.c
*/
#include <emscripten.h>
#include <stdio.h>
#include <stdbool.h>
#include <SDL2/SDL.h>
#include <cairo/cairo.h>

int
main(int argc, char *argv[])
{
  SDL_Init(SDL_INIT_VIDEO);

  SDL_Window *window = SDL_CreateWindow("An SDL2 window",
                                        SDL_WINDOWPOS_UNDEFINED,
                                        SDL_WINDOWPOS_UNDEFINED,
                                        640,
                                        480,
                                        SDL_WINDOW_SHOWN | SDL_WINDOW_ALLOW_HIGHDPI);

  SDL_Renderer *renderer = SDL_CreateRenderer(window,
                                              -1,
                                              SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);

  int window_width;
  int window_height;
  SDL_GetWindowSize(window, &window_width, &window_height);

  printf("window_width=%d\n"
         "window_height=%d\n",
         window_width, window_height);

  int renderer_width;
  int renderer_height;
  SDL_GetRendererOutputSize(renderer, &renderer_width, &renderer_height);

  printf("renderer_width=%d\n"
         "renderer_height=%d\n",
         renderer_width, renderer_height);

  int cairo_x_multiplier = renderer_width / window_width;
  int cairo_y_multiplier = renderer_height / window_height;

  SDL_Surface *sdl_surface = SDL_CreateRGBSurface(0,
                                                  renderer_width,
                                                  renderer_height,
                                                  32,
                                                  0x00ff0000,
                                                  0x0000ff00,
                                                  0x000000ff,
                                                  0);

  printf("sdl_surface->w=%d\n"
         "sdl_surface->h=%d\n"
         "sdl_surface->pitch=%d\n",
         sdl_surface->w, sdl_surface->h, sdl_surface->pitch);
  printf("sdl_surface->format->format=%s\n",
         SDL_GetPixelFormatName(sdl_surface->format->format));

  cairo_surface_t *cr_surface = cairo_image_surface_create_for_data((unsigned char *)sdl_surface->pixels,
                                                                       CAIRO_FORMAT_RGB24,
                                                                       sdl_surface->w,
                                                                       sdl_surface->h,
                                                                       sdl_surface->pitch);

  cairo_surface_set_device_scale(cr_surface, cairo_x_multiplier, cairo_y_multiplier);

  cairo_t *cr = cairo_create(cr_surface);

  SDL_SetRenderDrawColor(renderer, 0, 0, 0, 0);
  SDL_RenderClear(renderer);

  // White background with SDL2 API
  // SDL_FillRect(sdl_surface, NULL, SDL_MapRGB(sdl_surface->format, 255, 255, 255));

  // White background with cairo API
  cairo_set_source_rgba(cr, 1, 1, 1, 1.0);
  cairo_rectangle(cr, 0, 0, 640, 480);
  cairo_fill(cr);

  double xc = 320.0;
  double yc = 240.0;
  double radius = 200.0;
  double angle1 = 45.0  * (M_PI/180.0);
  double angle2 = 180.0 * (M_PI/180.0);

  cairo_set_source_rgba(cr, 0, 0, 0, 1.0);
  cairo_set_line_width(cr, 10.0);
  cairo_arc(cr, xc, yc, radius, angle1, angle2);
  cairo_stroke(cr);

  cairo_set_source_rgba(cr, 1, 0.2, 0.2, 0.6);
  cairo_set_line_width(cr, 6.0);

  cairo_arc(cr, xc, yc, 10.0, 0, 2*M_PI);
  cairo_fill(cr);

  cairo_arc(cr, xc, yc, radius, angle1, angle1);
  cairo_line_to(cr, xc, yc);
  cairo_arc(cr, xc, yc, radius, angle2, angle2);
  cairo_line_to(cr, xc, yc);
  cairo_stroke(cr);

  SDL_Texture *texture = SDL_CreateTextureFromSurface(renderer, sdl_surface);
  SDL_FreeSurface(sdl_surface);

  SDL_RenderCopy(renderer, texture, NULL, NULL);
  SDL_RenderPresent(renderer);

  bool done = false;
  while (!done) {
    SDL_Event event;
    while (SDL_PollEvent(&event)) {
      switch (event.type) {
      case SDL_QUIT:
        done = true;
        break;
      default:
        break;
      }
    }
    // SDL_Delay(100);
    emscripten_sleep(100);
  }

  cairo_destroy(cr);
  cairo_surface_destroy(cr_surface);

  SDL_DestroyTexture(texture);
  SDL_DestroyRenderer(renderer);
  SDL_DestroyWindow(window);

  SDL_Quit();

  return 0;
}
