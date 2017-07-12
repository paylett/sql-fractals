with dragon ( x1,y1,x2,y2,depth )
as
( 
  select convert(float,0),convert(float,0), convert(float,1),convert(float,0),12
  union all
  select x1,y1,(x1+x2)*0.5-(y2-y1)*0.5, (y1+y2)*0.5+(x2-x1)*0.5,depth-1 from dragon where depth > 0
  union all
  select x2,y2,(x1+x2)*0.5-(y2-y1)*0.5, (y1+y2)*0.5+(x2-x1)*0.5,depth-1 from dragon where depth > 0
)
select
geometry::STGeomFromText('LINESTRING(' +
  convert(varchar,x1) + ' ' + convert(varchar,y1) + ',' +
  convert(varchar,x2) + ' ' + convert(varchar,y2) + ')',0)
  from dragon  where depth = 0
