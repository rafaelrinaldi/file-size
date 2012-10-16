# file-size
Retrieve the total bytes of any file from the client-side.

---
### Usage

	<!DOCTYPE html>

	<html>

		<head />

		<body>

			<object type="application/x-shockwave-flash" data="./file_size.swf">
				<param name="flashvars" value="file=./image.jpg&onComplete=onComplete">
			</object>

			<script type="text/javascript">

				function onComplete( p_bytes ) {
					console.log("File loaded! File weight is " + (p_bytes / 1024 ^ 0) + "KB (" + p_bytes + " bytes)");
				}

			</script>

		</body>

	</html>
	
Take a look at [this demo][demo] which uses all features available. You may also check the complete [documentation][docs].

### License

[MIT][mit] licensed.

[demo]:./file-size/tree/gh-pages
[docs]:./file-size/tree/gh-pages/docs
[mit]:./file-size/tree/master/LICENSE