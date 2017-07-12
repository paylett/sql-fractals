with sierpinski ( x1,y1,x2,y2,x3,y3,depth ) as
( 
  select convert(float,0),convert(float,0),
         convert(float,1),convert(float,0),
         convert(float,0.5),SQRT(3)/2,1
  union all select x1,y1,(x1+x2)/2,(y1+y2)/2,(x1+x3)/2,(y1+y3)/2,depth+1 from sierpinski where depth <= 7
  union all select x2,y2,(x2+x3)/2,(y2+y3)/2,(x2+x1)/2,(y2+y1)/2,depth+1 from sierpinski where depth <= 7
  union all select x3,y3,(x3+x1)/2,(y3+y1)/2,(x3+x2)/2,(y3+y2)/2,depth+1 from sierpinski where depth <= 7
)
select geometry::STGeomFromText('POLYGON((' +
  convert(varchar,x1) + ' ' + convert(varchar,y1) + ',' +
  convert(varchar,x2) + ' ' + convert(varchar,y2) + ',' +
  convert(varchar,x3) + ' ' + convert(varchar,y3) + ',' +
  convert(varchar,x1) + ' ' + convert(varchar,y1) + '))',0)
  from sierpinski where depth=7
  
