with points (x1,y1,x2,y2,depth) as
(
	select convert(float,-2.40), convert(float,-2.40), convert(float,2.40), convert(float,2.40), 8
	union all select x1,y1,(x1+x2)/2,(y1+y2)/2,depth-1 from points where depth>0
	union all select (x1+x2)/2,y1,x2,(y1+y2)/2,depth-1 from points where depth>0
	union all select x1,(y1+y2)/2,(x1+x2)/2,y2,depth-1 from points where depth>0
	union all select (x1+x2)/2,(y1+y2)/2,x2,y2,depth-1 from points where depth>0
),
mandelbrot(x1,y1,x2,y2,x,y,depth) as
(
	select x1,y1,x2,y2,convert(float,0),convert(float,0),20 from points where depth=0
	union all
	select x1,y1,x2,y2, x*x-y*y+x1, 2*x*y+y1,depth-1 from mandelbrot where depth > 0 and (x*x+y*y<4)
)
select geometry::STGeomFromText('POLYGON((' +
  convert(varchar,x1) + ' ' + convert(varchar,y1) + ',' +
  convert(varchar,x1) + ' ' + convert(varchar,y2) + ',' +
  convert(varchar,x2) + ' ' + convert(varchar,y2) + ',' +
  convert(varchar,x2) + ' ' + convert(varchar,y1) + ',' +
  convert(varchar,x1) + ' ' + convert(varchar,y1) + '))',0)
  from mandelbrot where depth = 0
  
