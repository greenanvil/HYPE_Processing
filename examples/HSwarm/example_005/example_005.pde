HColorField colors;
HSwarm swarm;
HDrawablePool pool;
HTimer timer;

void setup() {
	size(640,640);
	H.init(this).background(#202020).autoClear(false);
	smooth();

	colors = new HColorField(width, height)
		.addPoint(0, height/2, #FF0066, 0.5f)
		.addPoint(width, height/2, #3300FF, 0.5f)
		.fillOnly()
		// .strokeOnly()
		// .fillAndStroke()
	;

	swarm = new HSwarm()
		.addGoal(H.mouse())
		.speed(5)
		.turnEase(0.05f)
		.twitch(20)
	;

	pool = new HDrawablePool(40);
	pool.autoAddToStage()
		.add (
			new HRect()
			.rounding(4)
		)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.size((int)random(10,20), (int)random(2,6) )
						.strokeWeight(2)
						.stroke(#000000, 100)
						.fill( #000000 )
						.loc( width/2, height/2 )
						.anchorAt( H.CENTER )
					;

					colors.applyColor( d );

					swarm.addTarget(d);
				}
			}
		)
	;

	timer = new HTimer()
		.numCycles( pool.numActive() )
		.interval(250)
		.callback(
			new HCallback() { 
				public void run(Object obj) {
					pool.request();
				}
			}
		)
	;
}

void draw() {
	HIterator<HDrawable> it = pool.iterator();

	while(it.hasNext()) {
		HDrawable d = it.next();
		colors.applyColor(d.fill(#000000));
	}

	H.drawStage();
}

