import 'package:flutter/material.dart';

class HomeBarberCard extends StatelessWidget {
  final bool isRanked;
  final String name;
  final double distance;
  final double? rate;
  const HomeBarberCard({super.key, required this.isRanked, required this.name, required this.distance, this.rate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Container(
        height: MediaQuery.of(context).size.height / 2.35,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          border: Border.all(
              color: Colors.grey.withOpacity(0.3),
              width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                height:
                MediaQuery.of(context).size.height /
                    4,
                width: MediaQuery.of(context).size.width *
                    0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1.5),
                  image: const DecorationImage(
                      image: AssetImage(
                          "assets/barbershopEg.jpg"),
                      fit: BoxFit.cover),
                ),
                child: isRanked ? Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 25,
                        width: 45,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD4AF37),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.star, color: Colors.black, size: 15,),
                            const SizedBox(width: 2),
                            Text("$rate", style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12, color: Colors.black),),
                          ],
                        ),
                      ),
                    ),
                  ],
                ) : Container(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  const Text(
                    "OPEN NOW",
                    style: TextStyle(
                      color: Color(0xFFD4AF37),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "from 9:00 to 21:00",
                    style: TextStyle(
                      color: Colors.grey.withOpacity(0.5),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 8, bottom: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.gps_fixed,
                    color: Color(0xFFD4AF37),
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "$distance km",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width *
                      0.5,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD4AF37),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "BOOK NOW",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
