# Marvelgram app

Marvelgram app - is a gallery of Marvel comics characters.

- [Figma design](https://www.figma.com/file/CDlyQFPB1BsuixWRuNhSyw/Marvel-Test-Task-iOS?node-id=0%3A1)
- JSON-data from [endpoint](https://static.upstarts.work/tests/marvelgram/klsZdDg50j2.json)

## Overview

<table>
	<thead>
		<tr>
			<th>Launch</th>
			<th>Search</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>
				<img src="resources/launch.gif" width="300"/>
			</td>
			<td>
				<img src="resources/search.gif" width="300"/>
			</td>
		</tr>
	</tbody>
</table>

<table>
	<thead>
		<tr>
			<th>Details</th>
			<th>Layout</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>
				<img src="resources/details.gif" width="300"/>
			</td>
			<td>
				<img src="resources/layout.gif" width="300"/>
			</td>
		</tr>
	</tbody>
</table>

## FAQ

- Q: Isn't the project too simple for a VIPER-like architecture? Why didn't you use classic MVC?
- A: I wanted to train in architecture, and MVP seemed the easiest of all. As for the Coordinator pattern, it's the same story. I don't like to build next UIViewController in the same controller (violation of SOLID, code duplication)

---
- Q: Why replace **self.view** in `func loadView()` some kind of **view**?
- A: As for me UIViewController first of all control flow of screen (lol). My consciousness has changed [this video](https://www.youtube.com/watch?v=7HgbcTqxoN4&t=631s) by Paul Hudson. Therefore, by doing so, I unload it

---
- Q: Why didn't I use Image Download frameworks ([SDWebImage](https://github.com/SDWebImage/SDWebImage), [AlamofireImage](https://github.com/Alamofire/AlamofireImage), etc...) ?
- A: I wanted to practice downloading and caching images on my own without pods

## Technical Requirements

- UIKit
- iOS 12.0+
- Portrait mode only
- No frameworks (preferably)
- All screen sizes must me supported: from iPhone SE to iPhone 13 Pro Max.
