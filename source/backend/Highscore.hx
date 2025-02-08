package backend;

class Highscore
{
	public static var weekScores:Map<String, Int> = new Map();
	public static var weekStars:Map<String, Int> = new Map();
	public static var songScores:Map<String, Int> = new Map<String, Int>();
	public static var songRating:Map<String, Float> = new Map<String, Float>();
	public static var starsGained:Map<String, Int> = new Map<String, Int>();

	public static function resetSong(song:String, diff:Int = 0):Void
	{
		var daSong:String = formatSong(song, diff);
		setScore(daSong, 0);
		setRating(daSong, 0);
		setStars(daSong, 0);
	}

	public static function resetWeek(week:String, diff:Int = 0):Void
	{
		var daWeek:String = formatSong(week, diff);
		setWeekScore(daWeek, 0);
		setWeekStars(daWeek, 0);
	}

	public static function saveScore(song:String, score:Int = 0, ?diff:Int = 0, ?rating:Float = -1, stars:Int = 0):Void
	{
		if(song == null) return;
		var daSong:String = formatSong(song, diff);

		if (songScores.exists(daSong))
		{
			if (songScores.get(daSong) < score)
			{
				setScore(daSong, score);
				if(rating >= 0) setRating(daSong, rating);
			}
		}
		else
		{
			setScore(daSong, score);
			if(rating >= 0) setRating(daSong, rating);
		}

		if (starsGained.exists(daSong))
		{
			if (starsGained.get(daSong) < stars)
			{
				setStars(daSong, stars);
			}
		}
		else
		{
			setStars(daSong, stars);
		}
	}

	public static function saveWeekScore(week:String, score:Int = 0, ?diff:Int = 0, stars:Int = 0):Void
	{
		var daWeek:String = formatSong(week, diff);

		if (weekScores.exists(daWeek))
		{
			if (weekScores.get(daWeek) < score)
			{
				setWeekScore(daWeek, score);
			}
		}
		else
		{
			setWeekScore(daWeek, score);
		}

		if (weekStars.exists(daWeek))
		{
			if (weekStars.get(daWeek) < stars)
			{
				setWeekStars(daWeek, stars);
			}
		}
		else
		{
			setWeekStars(daWeek, stars);
		}
	}

	/**
	 * YOU SHOULD FORMAT SONG WITH formatSong() BEFORE TOSSING IN SONG VARIABLE
	 */
	static function setScore(song:String, score:Int):Void
	{
		// Reminder that I don't need to format this song, it should come formatted!
		songScores.set(song, score);
		FlxG.save.data.songScores = songScores;
		FlxG.save.flush();
	}
	static function setWeekScore(week:String, score:Int):Void
	{
		// Reminder that I don't need to format this song, it should come formatted!
		weekScores.set(week, score);
		FlxG.save.data.weekScores = weekScores;
		FlxG.save.flush();
	}

	static function setWeekStars(week:String, stars:Int):Void
	{
		// Reminder that I don't need to format this song, it should come formatted!
		weekStars.set(week, stars);
		FlxG.save.data.weekStars = weekStars;
		FlxG.save.flush();
	}

	static function setRating(song:String, rating:Float):Void
	{
		// Reminder that I don't need to format this song, it should come formatted!
		songRating.set(song, rating);
		FlxG.save.data.songRating = songRating;
		FlxG.save.flush();
	}

	static function setStars(song:String, stars:Int):Void
	{
		// Reminder that I don't need to format this song, it should come formatted!
		starsGained.set(song, stars);
		FlxG.save.data.starsGained = starsGained;
		FlxG.save.flush();
	}

	public static function formatSong(song:String, diff:Int):String
	{
		return Paths.formatToSongPath(song) + Difficulty.getFilePath(diff);
	}

	public static function getScore(song:String, diff:Int):Int
	{
		var daSong:String = formatSong(song, diff);
		if (!songScores.exists(daSong))
			setScore(daSong, 0);

		return songScores.get(daSong);
	}

	public static function getRating(song:String, diff:Int):Float
	{
		var daSong:String = formatSong(song, diff);
		if (!songRating.exists(daSong))
			setRating(daSong, 0);

		return songRating.get(daSong);
	}

	public static function getStars(song:String, diff:Int):Int
	{
		var daSong:String = formatSong(song, diff);
		if (!starsGained.exists(daSong))
			setStars(daSong, 0);
	
		return starsGained.get(daSong);
	}

	public static function getWeekScore(week:String, diff:Int):Int
	{
		var daWeek:String = formatSong(week, diff);
		if (!weekScores.exists(daWeek))
			setWeekScore(daWeek, 0);

		return weekScores.get(daWeek);
	}

	public static function getWeekStars(week:String, diff:Int):Int
	{
		var daWeek:String = formatSong(week, diff);
		if (!weekStars.exists(daWeek))
			setWeekStars(daWeek, 0);

		return weekStars.get(daWeek);
	}

	public static function load():Void
	{
		if (FlxG.save.data.weekScores != null)
			weekScores = FlxG.save.data.weekScores;

		if (FlxG.save.data.weekStars != null)
			weekStars = FlxG.save.data.weekStars;

		if (FlxG.save.data.songScores != null)
			songScores = FlxG.save.data.songScores;

		if (FlxG.save.data.songRating != null)
			songRating = FlxG.save.data.songRating;

		if (FlxG.save.data.starsGained != null)
			starsGained = FlxG.save.data.starsGained;
	}
}