import 'package:velotoulouse/model/docks/dock.dart';
import 'package:velotoulouse/model/station/station.dart';
import 'package:velotoulouse/model/subscription/subscription_plan.dart';

class DummyData {
  static const List<SubscriptionPlan> plans = [
    SubscriptionPlan(
      id: '1',
      name: 'DAY PASS',
      price: 9,
      period: 'day',
      duration: '1 day or 24 hours',
      freeMinutes: 30,
    ),
    SubscriptionPlan(
      id: '2',
      name: 'MONTHLY PASS',
      price: 99,
      period: 'month',
      duration: '30 days',
      freeMinutes: 30,
      badge: 'BEST FOR DAILY COMMUTERS',
    ),
    SubscriptionPlan(
      id: '3',
      name: 'ANNUAL PASS',
      price: 999,
      period: 'year',
      duration: '365 days',
      freeMinutes: 60,
    ),
  ];

  static List<Station> stations = [
    Station(
      id: '1',
      name: 'WAT PHNOM',
      streetName: 'Confederation de la Russie Blvd, Khan Daun Penh',
      latitude: 11.5754,
      longitude: 104.9214,
      dock: [
        Dock(id: '01', bike: 'BIKE-001'),
        Dock(id: '02', bike: 'BIKE-002'),
        Dock(id: '03', bike: 'BIKE-003'),
      ],
    ),
    Station(
      id: '2',
      name: 'ROYAL PALACE',
      streetName: 'Samdech Sothearos Blvd, Khan Daun Penh',
      latitude: 11.5626,
      longitude: 104.9304,
      dock: [
        Dock(id: '01', bike: 'BIKE-011'),
        Dock(id: '02', bike: 'BIKE-012'),
        Dock(id: '03', bike: 'BIKE-013'),
        Dock(id: '04', bike: 'BIKE-014'),
        Dock(id: '05', bike: 'BIKE-015'),
        Dock(id: '06', bike: 'BIKE-016'),
        Dock(id: '07', bike: 'BIKE-017'),
        Dock(id: '08', bike: 'BIKE-018'),
        Dock(id: '09', bike: 'BIKE-019'),
        Dock(id: '10', bike: 'BIKE-020'),
        Dock(id: '11', bike: 'BIKE-021'),
        Dock(id: '12', bike: 'BIKE-022'),
      ],
    ),
    Station(
      id: '4',
      name: 'RIVERSIDE',
      streetName: 'Sisowath Quay, Khan Daun Penh',
      latitude: 11.5638,
      longitude: 104.9320,
      dock: [
        Dock(id: '01', bike: 'BIKE-031'),
        Dock(id: '02', bike: 'BIKE-032'),
        Dock(id: '03', bike: 'BIKE-033'),
        Dock(id: '04', bike: 'BIKE-034'),
        Dock(id: '05', bike: 'BIKE-035'),
      ],
    ),
    Station(
      id: '5',
      name: 'INDEPENDENCE MONUMENT',
      streetName: 'Norodom Blvd, Khan Chamkarmon',
      latitude: 11.5535,
      longitude: 104.9300,
      dock: [
        Dock(id: '01', bike: 'BIKE-041'),
        Dock(id: '02', bike: 'BIKE-042'),
        Dock(id: '03', bike: 'BIKE-043'),
        Dock(id: '04', bike: 'BIKE-044'),
        Dock(id: '05', bike: 'BIKE-045'),
        Dock(id: '06', bike: 'BIKE-046'),
        Dock(id: '07', bike: 'BIKE-047'),
        Dock(id: '08', bike: 'BIKE-048'),
      ],
    ),
    Station(
      id: '6',
      name: 'OLYMPIC STADIUM',
      streetName: 'Sihanouk Blvd, Khan Chamkarmon',
      latitude: 11.5586,
      longitude: 104.9112,
      dock: [
        Dock(id: '01', bike: 'BIKE-051'),
        Dock(id: '02', bike: 'BIKE-052'),
        Dock(id: '03', bike: 'BIKE-053'),
      ],
    ),
    Station(
      id: '7',
      name: 'TOUL SLENG MUSEUM',
      streetName: 'St.113, Khan Chamkarmon',
      latitude: 11.5494,
      longitude: 104.9173,
      dock: [
        Dock(id: '01', bike: 'BIKE-061'),
        Dock(id: '02', bike: 'BIKE-062'),
        Dock(id: '03', bike: 'BIKE-063'),
        Dock(id: '04', bike: 'BIKE-064'),
        Dock(id: '05', bike: 'BIKE-065'),
        Dock(id: '06', bike: 'BIKE-066'),
        Dock(id: '07', bike: 'BIKE-067'),
      ],
    ),
    Station(
      id: '8',
      name: 'BKK1 MARKET',
      streetName: 'St.278, Khan Chamkarmon',
      latitude: 11.5462,
      longitude: 104.9222,
      dock: [
        Dock(id: '01', bike: 'BIKE-071'),
        Dock(id: '02', bike: 'BIKE-072'),
        Dock(id: '03', bike: 'BIKE-073'),
      ],
    ),
  ];
}
