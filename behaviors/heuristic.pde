import java.lang.Math;

interface Heuristic<T> {
  float value(T start, T goal);
}

class Manhattan implements Heuristic<Point> {
  float value(Point start, Point goal) {
    return abs(goal.x - start.x) + abs(goal.y - start.y);
  }
}

class Euclidean implements Heuristic<Point> {
  float value(Point start, Point goal) {
    return (float) Math.sqrt(Math.pow((goal.x - start.x),2) + Math.pow((goal.y - start.y),2));
  }
}

class Constant implements Heuristic<Point> {
  float value(Point start, Point goal) {
    return 100;
  }
}

class Power implements Heuristic<Point> {
  float value(Point start, Point goal) {
    return abs((float)(Math.pow(goal.x, 2) - Math.pow(start.x, 2) + Math.pow(goal.y, 2) - Math.pow(start.y, 2)));
  }
}

class Random implements Heuristic<Point> {
  float value(Point start, Point goal) {
    return random(10);
  }
}
