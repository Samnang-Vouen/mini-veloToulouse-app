import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velotoulouse/model/station/station.dart';
import 'package:velotoulouse/ui/screens/station/view_model/station_detail_view_model.dart';
import 'package:velotoulouse/ui/widgets/dock_booking_modal.dart';
import 'package:velotoulouse/ui/screens/subscription/subcription_screen.dart';
import 'package:velotoulouse/ui/theme/theme.dart';
import 'package:velotoulouse/ui/widgets/book_hint_widget.dart';
import 'package:velotoulouse/ui/widgets/dock_list_item_widget.dart';
import 'package:velotoulouse/ui/widgets/station_header_widget.dart';

class StationContent extends StatelessWidget {
  final Station station;

  const StationContent({super.key, required this.station});

  void _popWithCount(BuildContext context) {
    final bookedIds = context.read<StationDetailViewModel>().bookedDockIds;
    Navigator.of(context).pop(Set<String>.of(bookedIds));
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<StationDetailViewModel>();

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _popWithCount(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
            onPressed: () => _popWithCount(context),
          ),
          title: Text(
            'Station Info',
            style: AppTextStyles.title.copyWith(color: AppColors.textDark),
          ),
          centerTitle: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(3),
            child: Container(height: 3, color: AppColors.primary),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StationHeaderWidget(
              station: station,
              availableBikesOverride:
                  station.availableBikes - vm.bookedDockIds.length,
            ),
            const Divider(height: 1, color: AppColors.divider),
            const BookHintWidget(),
            Expanded(
              child: ListView.separated(
                itemCount: station.dock.length,
                separatorBuilder: (_, _) =>
                    const Divider(height: 1, color: AppColors.primary),
                itemBuilder: (context, index) {
                  final dock = station.dock[index];
                  final isSelected = dock.id == vm.selectedDockId;
                  final isBooked = vm.bookedDockIds.contains(dock.id);
                  return DockListItemWidget(
                    dock: dock,
                    isSelected: isSelected,
                    isBooked: isBooked,
                    onCancel: isBooked
                        ? () => context
                              .read<StationDetailViewModel>()
                              .cancelBooking(dock.id)
                        : null,
                    onTap: () {
                      context.read<StationDetailViewModel>().toggleDock(
                        dock.id,
                      );
                      showDialog(
                        context: context,
                        builder: (_) => DockBookingModal(
                          dock: dock,
                          activeSubscription: vm.activeSubscription,
                          onConfirm: () {
                            context
                                .read<StationDetailViewModel>()
                                .confirmBooking(dock.id);
                          },
                          onSelectPass: () {
                            Navigator.of(context)
                                .push(
                                  MaterialPageRoute(
                                    builder: (_) => const SubcriptionScreen(),
                                  ),
                                )
                                .then((_) {
                                  if (context.mounted) {
                                    context
                                        .read<StationDetailViewModel>()
                                        .reloadSubscription();
                                  }
                                });
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
