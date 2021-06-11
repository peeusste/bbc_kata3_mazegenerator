package graphics

import (
	"image"
	"image/color"
	"image/png"
	"io"

	"github.com/betandr/bbc_kata3_mazegenerator/maze"
	"github.com/disintegration/imaging"
)

var img *image.RGBA
var col color.Color

var red = color.RGBA{255, 0, 0, 255}
var green = color.RGBA{0, 255, 0, 255}
var blue = color.RGBA{0, 0, 255, 255}
var orange = color.RGBA{255, 69, 0, 255}

func hriz(xStart, xEnd, y int) {
	for ; xStart < xEnd; xStart++ {
		img.Set(xStart, y, col)
	}
}

func vert(x, yStart, yEnd int) {
	for ; yStart < yEnd; yStart++ {
		img.Set(x, yStart, col)
	}
}

func fill(xStart, yStart, width, height int) {
	for x := xStart; x < width; x++ {
		for y := yStart; y < height; y++ {
			img.Set(x, y, col)
		}
	}
}

func Render(w io.Writer, m *maze.Maze, goal maze.Position) {
	cellSize := 20
	width := len(m.Cells) * cellSize
	height := len(m.Cells[0]) * cellSize
	img = image.NewRGBA(image.Rect(0, 0, width, height))

	// background-
	col = color.White
	fill(0, 0, width, height)
	// -background

	// goal-
	col = green
	goalX := goal.X * cellSize
	goalY := goal.Y * cellSize
	fill(goalX, goalY, goalX+cellSize, goalY+cellSize)
	// -goal

	col = color.Black

	// outline-
	hriz(0, width-1, 0)
	hriz(0, width-1, height-1)
	vert(0, 0, width-1)
	vert(width-1, 0, width-1)
	// -outline

	// cells-
	xStart := 0
	xEnd := 0
	yStart := 0
	yEnd := yStart + cellSize
	for row := 0; row < len(m.Cells[0]); row++ {
		for col := 0; col < len(m.Cells); col++ {
			cell := m.Cells[col][row]
			xStart = col * cellSize
			xEnd = xStart + cellSize
			if !cell.NorthRoute {
				hriz(xStart, xEnd, yStart)
			}

			if !cell.EastRoute {
				vert(xStart, yStart, yEnd)
			}
		}
		yStart += cellSize
		yEnd = yStart + cellSize
	}
	// -cells

	png.Encode(w, imaging.FlipH(img))
}
