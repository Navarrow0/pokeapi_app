
part of 'widgets.dart';

class ListSkeleton extends StatelessWidget {
  const ListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[600]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.separated(
        itemCount: 6,
        shrinkWrap: true,
        separatorBuilder: (_, index) => const SizedBox(height: 10,),
        itemBuilder: (context, index) {
          return const Skeleton(
            height: 200,
          );
        },
      ),
    );
  }
}


class Skeleton extends StatelessWidget {
  const Skeleton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          borderRadius:
          const BorderRadius.all(Radius.circular(16.0))),
    );
  }
}