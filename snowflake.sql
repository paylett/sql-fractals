with snowflake ( x1,y1,x2,y2,depth ) as
( 
  /* seed triangle */
  select convert(float,0),convert(float,0), convert(float,1),convert(float,0),4 --depth
  union all select convert(float,1),convert(float,0), convert(float,0.5),sqrt(3)/2,4 --depth
  union all select convert(float,0.5),sqrt(3)/2, convert(float,0),convert(float,0),4 --depth
  /* recursive pattern triangle */
  union all select x1,y1,(x1*2+x2)/3,(y1*2+y2)/3,depth-1 from snowflake where depth >= 0
  union all select (x1*2+x2)/3,(y1*2+y2)/3, x1+(x2-x1)*0.5+(y2-y1)*SQRT(3)/6, y1+(y2-y1)*0.5-(x2-x1)*SQRT(3)/6, depth-1 from snowflake where depth >= 0
  union all select x1+(x2-x1)*0.5+(y2-y1)*SQRT(3)/6, y1+(y2-y1)*0.5-(x2-x1)*SQRT(3)/6, (x1+x2*2)/3,(y1+y2*2)/3,depth-1 from snowflake where depth >= 0
  union all select (x1+x2*2)/3,(y1+y2*2)/3,x2,y2,depth-1 from snowflake where depth >= 0
)
select geometry::STGeomFromText('LINESTRING(' +
  convert(varchar,x1) + ' ' + convert(varchar,-y1) + ',' +
  convert(varchar,x2) + ' ' + convert(varchar,-y2) + ')',0)
  from snowflake  where depth=0
  
