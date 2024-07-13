import 'package:flutter/material.dart';

class TabItem {
  TabItem({
    required this.title,
    required this.action,
    required this.widget,
  });

  final String title;
  final Function action;
  final Widget widget;
}

class TabViewWidget extends StatefulWidget {
  const TabViewWidget({
    super.key,
    required this.tabs,
    this.isLoading = false,
    this.onChange,
  });
  final List<TabItem> tabs;
  final Function(TabItem)? onChange;
  final bool isLoading;

  @override
  State<TabViewWidget> createState() => _TabViewWidgetState();
}

class _TabViewWidgetState extends State<TabViewWidget> {
  int idActive = 0;
  Color titleColorActive = Colors.blueGrey;
  Color titleColorInactive = Colors.grey;

  @override
  Widget build(BuildContext context) {
    if (widget.tabs.isNotEmpty) {
      return Flexible(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: widget.tabs.map((tabItem) {
                  final index = widget.tabs
                      .indexWhere((item) => tabItem.title == item.title);
                  return Flexible(
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          idActive = index;
                        });
                        widget.onChange?.call(tabItem);
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: idActive == index
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Text(
                              tabItem.title,
                              style: TextStyle(
                                color: idActive == index
                                    ? titleColorActive
                                    : titleColorInactive,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            if (widget.isLoading)
              const Flexible(child: Center(child: CircularProgressIndicator()))
            else
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      // color: Colors.grey,
                      ),
                  child: widget.tabs[idActive].widget,
                ),
              ),
          ],
        ),
      );
    }
    return const SizedBox();
  }

  EdgeInsets? bambamSpacer(
    TabItem tabItem,
  ) {
    if (widget.tabs.length == 1) {
      return const EdgeInsets.all(10.0);
    } else if (tabItem.title == widget.tabs.first.title) {
      return const EdgeInsets.only(left: 10.0);
    } else if (tabItem.title == widget.tabs.last.title) {
      return const EdgeInsets.only(right: 10.0);
    } else {
      const EdgeInsets.all(0);
    }
    return null;
  }
}
