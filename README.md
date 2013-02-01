[license]: http://opensource.org/licenses/MIT

# file-size
Retrieve the total bytes of any file from the client-side.

## Specification
The compiled .swf file weights **1KB** and runs under **Flash Player 9**.

## How it works
This tool currently retrieves the total bytes of a file by making a request. As soon as the bytes information are available the request is automatically cancelled.
In short, it doesn't loads the entire file you want to retrieve information from.

## Usage

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
	
## License
[MIT][license].