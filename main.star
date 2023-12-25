load("render.star", "render")
load("http.star", "http")

API_URL = "https://motd.bluevista.dev/motd"

def main():
	rep = http.get(API_URL)
	if rep.status_code != 200:
		fail("MOTD request failed with status %d", rep.status_code)

	motd = rep.json()["motd"]

	return render.Root(
		delay = 120,
		child = render.Column(
			children = [
				render.WrappedText(
					content = "ChatGPT MOTD",
					color = "#5555cc",
					linespacing = 0,
					width = 64,
				),
				render.Box(
					height = 1,
					width = 64,
					color = "#5555cc",
				),
				render.Marquee(
					child = render.WrappedText(
						content = motd,
						width = 64,
					),
					scroll_direction = "vertical",
					height = 23,
					offset_start = 24,
					offset_end = 24
				)
			]
		)
	)
