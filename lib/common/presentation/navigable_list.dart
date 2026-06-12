import 'package:canya_mobile/common/data/Navigable.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class NavigableList extends HookConsumerWidget
    with UiLoggy {
  final List<Navigable> items;

  const NavigableList({required this.items, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return items.isEmpty
        ? const SizedBox.shrink()
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: items
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                    child: NavigableTile(item: item),
                  ),
                )
                .toList(),
          );
  }
}

class NavigableTile extends HookConsumerWidget
    with UiLoggy {
  final Navigable item;

  const NavigableTile({required this.item, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tileHeight = 70.0;
    final showAction = true;
    final theme = Theme.of(context);
    final hasSubtitle =
        item.subtitle != null &&
        item.subtitle!.trim().isNotEmpty;

    return Container(
      height: tileHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: theme.colorScheme.outlineVariant
              .withValues(alpha: 0.5),
          width: 1.0,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Text(
                      item.title,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (hasSubtitle) ...[
                      // const SizedBox(height: 4.0),
                      Text(
                        item.subtitle!,
                        style: theme.textTheme.bodySmall
                            ?.copyWith(
                              color: theme
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            if (showAction)
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
                child: Container(
                  width: tileHeight * 2 / 3,
                  height: tileHeight,
                  color: theme.colorScheme.primaryContainer,
                  child: InkWell(
                    onTap: () => loggy.debug('tap tap'),
                    child: Center(
                      child: Icon(
                        Icons.chevron_right,
                        size: 22.0,
                        color: theme
                            .colorScheme
                            .onPrimaryContainer,
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
