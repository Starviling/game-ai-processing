HashMap<String, Node<Point>> generateCustomMapOne() {
  HashMap<String, Node<Point>> europeanUnion = new HashMap<String, Node<Point>>();
  // Create nodes
  Node<Point> portugal = new Node<Point>(new Point(2, 6));
  Node<Point> spain = new Node<Point>(new Point(3, 6));
  Node<Point> ireland = new Node<Point>(new Point(3, 12));
  Node<Point> france = new Node<Point>(new Point(5, 9));
  Node<Point> belgium = new Node<Point>(new Point(7, 10));
  Node<Point> luxembourg = new Node<Point>(new Point(8, 10));
  Node<Point> netherlands = new Node<Point>(new Point(8, 11));
  Node<Point> italy = new Node<Point>(new Point(10, 4));
  Node<Point> austria = new Node<Point>(new Point(10, 7));
  Node<Point> germany = new Node<Point>(new Point(10, 9));
  Node<Point> denmark = new Node<Point>(new Point(10, 12));
  Node<Point> slovenia = new Node<Point>(new Point(11, 6));
  Node<Point> czechoslovakia = new Node<Point>(new Point(11, 8));
  Node<Point> croatia = new Node<Point>(new Point(12, 5));
  Node<Point> hungary = new Node<Point>(new Point(12, 6));
  Node<Point> poland = new Node<Point>(new Point(12, 10));
  Node<Point> sweden = new Node<Point>(new Point(12, 15));
  Node<Point> slovakia = new Node<Point>(new Point(13, 7));
  Node<Point> lithuania = new Node<Point>(new Point(13, 12));
  Node<Point> latvia = new Node<Point>(new Point(14, 13));
  Node<Point> estonia = new Node<Point>(new Point(14, 14));
  Node<Point> finland = new Node<Point>(new Point(14, 16));
  Node<Point> greece = new Node<Point>(new Point(15, 3));
  Node<Point> romania = new Node<Point>(new Point(15, 6));
  Node<Point> bulgaria = new Node<Point>(new Point(16, 5));
  Node<Point> cyprus = new Node<Point>(new Point(19, 2));
  
  // Add the vertices
  europeanUnion.put("portugal", portugal);
  europeanUnion.put("spain", spain);
  europeanUnion.put("ireland", ireland);
  europeanUnion.put("france", france);
  europeanUnion.put("belgium", belgium);
  europeanUnion.put("luxembourg", luxembourg);
  europeanUnion.put("netherlands", netherlands);
  europeanUnion.put("italy", italy);
  europeanUnion.put("austria", austria);
  europeanUnion.put("germany", germany);
  europeanUnion.put("denmark", denmark);
  europeanUnion.put("slovenia", slovenia);
  europeanUnion.put("czechoslovakia", czechoslovakia);
  europeanUnion.put("croatia", croatia);
  europeanUnion.put("hungary", hungary);
  europeanUnion.put("poland", poland);
  europeanUnion.put("sweden", sweden);
  europeanUnion.put("slovakia", slovakia);
  europeanUnion.put("lithuania", lithuania);
  europeanUnion.put("latvia", latvia);
  europeanUnion.put("estonia", estonia);
  europeanUnion.put("finland", finland);
  europeanUnion.put("greece", greece);
  europeanUnion.put("romania", romania);
  europeanUnion.put("bulgaria", bulgaria);
  europeanUnion.put("cyprus", cyprus);
  
  // Add the edges
  europeanUnion.get("portugal").edgeTo(europeanUnion.get("spain"), distance(portugal, spain));
  europeanUnion.get("portugal").edgeTo(europeanUnion.get("ireland"), distance(portugal,ireland));
  europeanUnion.get("portugal").edgeTo(europeanUnion.get("italy"), distance(portugal, italy));
  
  europeanUnion.get("spain").edgeTo(europeanUnion.get("france"), distance(spain, france));
  europeanUnion.get("spain").edgeTo(europeanUnion.get("portugal"), distance(spain, portugal));
  europeanUnion.get("spain").edgeTo(europeanUnion.get("italy"), distance(spain, italy));
  europeanUnion.get("spain").edgeTo(europeanUnion.get("ireland"), distance(spain, ireland));
  
  europeanUnion.get("france").edgeTo(europeanUnion.get("spain"), distance(france, spain));
  europeanUnion.get("france").edgeTo(europeanUnion.get("ireland"), distance(france, ireland));
  europeanUnion.get("france").edgeTo(europeanUnion.get("belgium"), distance(france, belgium));
  europeanUnion.get("france").edgeTo(europeanUnion.get("luxembourg"), distance(france, luxembourg));
  europeanUnion.get("france").edgeTo(europeanUnion.get("italy"), distance(france, italy));
  
  europeanUnion.get("ireland").edgeTo(europeanUnion.get("portugal"), distance(ireland, portugal));
  europeanUnion.get("ireland").edgeTo(europeanUnion.get("spain"), distance(ireland, spain));
  europeanUnion.get("ireland").edgeTo(europeanUnion.get("france"), distance(ireland, france));
  europeanUnion.get("ireland").edgeTo(europeanUnion.get("belgium"), distance(ireland, belgium));
  europeanUnion.get("ireland").edgeTo(europeanUnion.get("netherlands"), distance(ireland, netherlands));
  europeanUnion.get("ireland").edgeTo(europeanUnion.get("denmark"), distance(ireland, denmark));
  europeanUnion.get("ireland").edgeTo(europeanUnion.get("germany"), distance(ireland, germany));
  
  europeanUnion.get("belgium").edgeTo(europeanUnion.get("france"), distance(belgium, france));
  europeanUnion.get("belgium").edgeTo(europeanUnion.get("ireland"), distance(belgium, ireland));
  europeanUnion.get("belgium").edgeTo(europeanUnion.get("netherlands"), distance(belgium, netherlands));
  europeanUnion.get("belgium").edgeTo(europeanUnion.get("luxembourg"), distance(belgium, luxembourg));
  
  europeanUnion.get("luxembourg").edgeTo(europeanUnion.get("france"), distance(luxembourg, france));
  europeanUnion.get("luxembourg").edgeTo(europeanUnion.get("netherlands"), distance(luxembourg, netherlands));
  europeanUnion.get("luxembourg").edgeTo(europeanUnion.get("belgium"), distance(luxembourg, belgium));
  europeanUnion.get("luxembourg").edgeTo(europeanUnion.get("germany"), distance(luxembourg, germany));
  
  europeanUnion.get("netherlands").edgeTo(europeanUnion.get("germany"), distance(netherlands, germany));
  europeanUnion.get("netherlands").edgeTo(europeanUnion.get("belgium"), distance(netherlands, belgium));
  europeanUnion.get("netherlands").edgeTo(europeanUnion.get("ireland"), distance(netherlands, ireland));
  
  europeanUnion.get("germany").edgeTo(europeanUnion.get("belgium"), distance(germany, belgium));
  europeanUnion.get("germany").edgeTo(europeanUnion.get("poland"), distance(germany, poland));
  europeanUnion.get("germany").edgeTo(europeanUnion.get("france"), distance(germany, france));
  europeanUnion.get("germany").edgeTo(europeanUnion.get("luxembourg"), distance(germany, luxembourg));
  europeanUnion.get("germany").edgeTo(europeanUnion.get("netherlands"), distance(germany, netherlands));
  europeanUnion.get("germany").edgeTo(europeanUnion.get("ireland"), distance(germany, ireland));
  europeanUnion.get("germany").edgeTo(europeanUnion.get("italy"), distance(germany, italy));
  europeanUnion.get("germany").edgeTo(europeanUnion.get("austria"), distance(germany, austria));
  europeanUnion.get("germany").edgeTo(europeanUnion.get("denmark"), distance(germany, denmark));
  europeanUnion.get("germany").edgeTo(europeanUnion.get("sweden"), distance(germany, sweden));
  europeanUnion.get("germany").edgeTo(europeanUnion.get("lithuania"), distance(germany, lithuania));
  europeanUnion.get("germany").edgeTo(europeanUnion.get("latvia"), distance(germany, latvia));
  europeanUnion.get("germany").edgeTo(europeanUnion.get("finland"), distance(germany, finland));
  europeanUnion.get("germany").edgeTo(europeanUnion.get("czechoslovakia"), distance(germany, czechoslovakia));
  
  europeanUnion.get("italy").edgeTo(europeanUnion.get("portugal"), distance(italy, portugal));
  europeanUnion.get("italy").edgeTo(europeanUnion.get("france"), distance(italy, france));
  europeanUnion.get("italy").edgeTo(europeanUnion.get("germany"), distance(italy, germany));
  europeanUnion.get("italy").edgeTo(europeanUnion.get("spain"), distance(italy, spain));
  europeanUnion.get("italy").edgeTo(europeanUnion.get("slovenia"), distance(italy,slovenia));
  europeanUnion.get("italy").edgeTo(europeanUnion.get("austria"), distance(italy, austria));
  europeanUnion.get("italy").edgeTo(europeanUnion.get("croatia"), distance(italy, croatia));
  europeanUnion.get("italy").edgeTo(europeanUnion.get("greece"), distance(italy, greece));
  europeanUnion.get("italy").edgeTo(europeanUnion.get("cyprus"), distance(italy, cyprus));
  
  europeanUnion.get("austria").edgeTo(europeanUnion.get("germany"), distance(austria, germany));
  europeanUnion.get("austria").edgeTo(europeanUnion.get("italy"), distance(austria, italy));
  europeanUnion.get("austria").edgeTo(europeanUnion.get("slovenia"), distance(austria, slovenia));
  europeanUnion.get("austria").edgeTo(europeanUnion.get("hungary"), distance(austria, hungary));
  europeanUnion.get("austria").edgeTo(europeanUnion.get("slovakia"), distance(austria, slovakia));
  europeanUnion.get("austria").edgeTo(europeanUnion.get("czechoslovakia"), distance(austria, czechoslovakia));
  
  europeanUnion.get("croatia").edgeTo(europeanUnion.get("italy"), distance(croatia, italy));
  europeanUnion.get("croatia").edgeTo(europeanUnion.get("slovenia"), distance(croatia, slovenia));
  europeanUnion.get("croatia").edgeTo(europeanUnion.get("hungary"), distance(croatia, hungary));
  
  europeanUnion.get("denmark").edgeTo(europeanUnion.get("ireland"), distance(denmark, ireland));
  europeanUnion.get("denmark").edgeTo(europeanUnion.get("sweden"), distance(denmark, sweden));
  europeanUnion.get("denmark").edgeTo(europeanUnion.get("germany"), distance(denmark, germany));
  europeanUnion.get("denmark").edgeTo(europeanUnion.get("poland"), distance(denmark, poland));
  europeanUnion.get("denmark").edgeTo(europeanUnion.get("lithuania"), distance(denmark, lithuania));
  europeanUnion.get("denmark").edgeTo(europeanUnion.get("latvia"), distance(denmark, latvia));
  europeanUnion.get("denmark").edgeTo(europeanUnion.get("estonia"), distance(denmark, estonia));
  europeanUnion.get("denmark").edgeTo(europeanUnion.get("finland"), distance(denmark, finland));
  
  europeanUnion.get("slovenia").edgeTo(europeanUnion.get("croatia"), distance(slovenia, croatia));
  europeanUnion.get("slovenia").edgeTo(europeanUnion.get("hungary"), distance(slovenia, hungary));
  europeanUnion.get("slovenia").edgeTo(europeanUnion.get("italy"), distance(slovenia, italy));
  europeanUnion.get("slovenia").edgeTo(europeanUnion.get("austria"), distance(slovenia, austria));
  
  europeanUnion.get("hungary").edgeTo(europeanUnion.get("croatia"), distance(hungary, croatia));
  europeanUnion.get("hungary").edgeTo(europeanUnion.get("austria"), distance(hungary, austria));
  europeanUnion.get("hungary").edgeTo(europeanUnion.get("romania"), distance(hungary, romania));
  europeanUnion.get("hungary").edgeTo(europeanUnion.get("slovakia"), distance(hungary, slovakia));
  europeanUnion.get("hungary").edgeTo(europeanUnion.get("slovenia"), distance(hungary, slovenia));
  
  europeanUnion.get("czechoslovakia").edgeTo(europeanUnion.get("austria"), distance(czechoslovakia, austria));
  europeanUnion.get("czechoslovakia").edgeTo(europeanUnion.get("germany"), distance(czechoslovakia, germany));
  europeanUnion.get("czechoslovakia").edgeTo(europeanUnion.get("slovakia"), distance(czechoslovakia, slovakia));
  europeanUnion.get("czechoslovakia").edgeTo(europeanUnion.get("poland"), distance(czechoslovakia, poland));
  
  europeanUnion.get("slovakia").edgeTo(europeanUnion.get("czechoslovakia"), distance(slovakia, czechoslovakia));
  europeanUnion.get("slovakia").edgeTo(europeanUnion.get("austria"), distance(slovakia, austria));
  europeanUnion.get("slovakia").edgeTo(europeanUnion.get("poland"), distance(slovakia, poland));
  europeanUnion.get("slovakia").edgeTo(europeanUnion.get("hungary"), distance(slovakia, hungary));
  
  europeanUnion.get("poland").edgeTo(europeanUnion.get("czechoslovakia"), distance(poland, czechoslovakia));
  europeanUnion.get("poland").edgeTo(europeanUnion.get("slovakia"), distance(poland, slovakia));
  europeanUnion.get("poland").edgeTo(europeanUnion.get("lithuania"), distance(poland, lithuania));
  europeanUnion.get("poland").edgeTo(europeanUnion.get("latvia"), distance(poland, latvia));
  europeanUnion.get("poland").edgeTo(europeanUnion.get("estonia"), distance(poland, estonia));
  europeanUnion.get("poland").edgeTo(europeanUnion.get("denmark"), distance(poland, denmark));
  europeanUnion.get("poland").edgeTo(europeanUnion.get("sweden"), distance(poland, sweden));
  
  europeanUnion.get("sweden").edgeTo(europeanUnion.get("germany"), distance(sweden, germany));
  europeanUnion.get("sweden").edgeTo(europeanUnion.get("finland"), distance(sweden, finland));
  europeanUnion.get("sweden").edgeTo(europeanUnion.get("estonia"), distance(sweden, estonia));
  europeanUnion.get("sweden").edgeTo(europeanUnion.get("latvia"), distance(sweden, latvia));
  europeanUnion.get("sweden").edgeTo(europeanUnion.get("lithuania"), distance(sweden, lithuania));
  europeanUnion.get("sweden").edgeTo(europeanUnion.get("poland"), distance(sweden, poland));
  europeanUnion.get("sweden").edgeTo(europeanUnion.get("denmark"), distance(sweden, denmark));
  
  europeanUnion.get("lithuania").edgeTo(europeanUnion.get("latvia"), distance(lithuania, latvia));
  europeanUnion.get("lithuania").edgeTo(europeanUnion.get("poland"), distance(lithuania, poland));
  europeanUnion.get("lithuania").edgeTo(europeanUnion.get("germany"), distance(lithuania, germany));
  europeanUnion.get("lithuania").edgeTo(europeanUnion.get("sweden"), distance(lithuania, sweden));
  europeanUnion.get("lithuania").edgeTo(europeanUnion.get("denmark"), distance(lithuania, denmark));
  europeanUnion.get("lithuania").edgeTo(europeanUnion.get("estonia"), distance(lithuania, estonia));
  
  europeanUnion.get("latvia").edgeTo(europeanUnion.get("germany"), distance(latvia, germany));
  europeanUnion.get("latvia").edgeTo(europeanUnion.get("lithuania"), distance(latvia, lithuania));
  europeanUnion.get("latvia").edgeTo(europeanUnion.get("sweden"), distance(latvia, sweden));
  europeanUnion.get("latvia").edgeTo(europeanUnion.get("poland"), distance(latvia, poland));
  europeanUnion.get("latvia").edgeTo(europeanUnion.get("denmark"), distance(latvia, denmark));
  europeanUnion.get("latvia").edgeTo(europeanUnion.get("estonia"), distance(latvia, estonia));
  
  europeanUnion.get("finland").edgeTo(europeanUnion.get("estonia"), distance(finland, estonia));
  europeanUnion.get("finland").edgeTo(europeanUnion.get("germany"), distance(finland, germany));
  europeanUnion.get("finland").edgeTo(europeanUnion.get("sweden"), distance(finland, sweden));
  europeanUnion.get("finland").edgeTo(europeanUnion.get("denmark"), distance(finland, denmark));
  
  europeanUnion.get("estonia").edgeTo(europeanUnion.get("latvia"), distance(estonia, latvia));
  europeanUnion.get("estonia").edgeTo(europeanUnion.get("denmark"), distance(estonia, denmark));
  europeanUnion.get("estonia").edgeTo(europeanUnion.get("finland"), distance(estonia, finland));
  europeanUnion.get("estonia").edgeTo(europeanUnion.get("sweden"), distance(estonia, sweden));
  europeanUnion.get("estonia").edgeTo(europeanUnion.get("poland"), distance(estonia, poland));
  europeanUnion.get("estonia").edgeTo(europeanUnion.get("lithuania"), distance(estonia, lithuania));
  
  europeanUnion.get("romania").edgeTo(europeanUnion.get("bulgaria"), distance(romania, bulgaria));
  europeanUnion.get("romania").edgeTo(europeanUnion.get("hungary"), distance(romania, hungary));
  
  europeanUnion.get("bulgaria").edgeTo(europeanUnion.get("greece"), distance(bulgaria, greece));
  europeanUnion.get("bulgaria").edgeTo(europeanUnion.get("romania"), distance(bulgaria, romania));
  
  europeanUnion.get("greece").edgeTo(europeanUnion.get("italy"), distance(greece, italy));
  europeanUnion.get("greece").edgeTo(europeanUnion.get("bulgaria"), distance(greece, bulgaria));
  europeanUnion.get("greece").edgeTo(europeanUnion.get("cyprus"), distance(greece, cyprus));

  europeanUnion.get("cyprus").edgeTo(europeanUnion.get("italy"), distance(cyprus, italy));
  europeanUnion.get("cyprus").edgeTo(europeanUnion.get("greece"), distance(cyprus, greece));
  // Return the map
  return europeanUnion;
}



float distance(Node<Point> a, Node<Point> b) {
  return (float) Math.sqrt(Math.pow((a.value.x - b.value.x), 2) + Math.pow((a.value.y - b.value.y), 2));
}
