import 'package:flutter/material.dart';
import '../../../shared/widgets/anchor_app_bar.dart';
import '../../../shared/widgets/anchor_drawer.dart';

class RemittanceCalculatorScreen extends StatefulWidget {
  const RemittanceCalculatorScreen({super.key});

  @override
  State<RemittanceCalculatorScreen> createState() =>
      _RemittanceCalculatorScreenState();
}

class _RemittanceCalculatorScreenState
    extends State<RemittanceCalculatorScreen> {
  String _fromCurrency = 'SGD';
  String _toCurrency = 'PHP';
  double _amount = 1000;
  String _sortBy = 'Best Value';

  // Exchange rates (hardcoded for demo)
  final Map<String, Map<String, double>> _exchangeRates = {
    'SGD': {'PHP': 37.45, 'USD': 0.74, 'MYR': 3.47},
    'PHP': {'SGD': 0.027, 'USD': 0.020, 'MYR': 0.093},
    'USD': {'SGD': 1.35, 'PHP': 50.25, 'MYR': 4.68},
    'MYR': {'SGD': 0.288, 'PHP': 10.75, 'USD': 0.214},
  };

  final List<Map<String, dynamic>> _providers = [
    {
      'name': 'Wise',
      'rating': 4.8,
      'reviews': 12453,
      'fee': 8.50,
      'speed': '24h',
      'tags': ['Mid-market rate', 'Fast transfer', 'Mobile app'],
      'discount': '60% off first transfer',
      'recommended': true,
    },
    {
      'name': 'Remitly',
      'rating': 4.6,
      'reviews': 8932,
      'fee': 3.99,
      'speed': '1h',
      'tags': ['Express delivery', 'Low fees', 'Trusted'],
      'discount': null,
      'recommended': false,
    },
    {
      'name': 'WorldRemit',
      'rating': 4.5,
      'reviews': 7821,
      'fee': 4.99,
      'speed': '12h',
      'tags': ['Cash pickup', 'Bank transfer', 'Mobile wallet'],
      'discount': null,
      'recommended': false,
    },
    {
      'name': 'Xoom',
      'rating': 4.4,
      'reviews': 6234,
      'fee': 5.99,
      'speed': '4h',
      'tags': ['PayPal', 'Fast', 'Reliable'],
      'discount': null,
      'recommended': false,
    },
    {
      'name': 'Remit2Home',
      'rating': 4.3,
      'reviews': 4532,
      'fee': 7.50,
      'speed': '24h',
      'tags': ['Bank transfer', 'Cash pickup'],
      'discount': null,
      'recommended': false,
    },
  ];

  double get _convertedAmount {
    final rate = _exchangeRates[_fromCurrency]?[_toCurrency] ?? 1.0;
    return _amount * rate;
  }

  double get _bestRate {
    return _convertedAmount;
  }

  double get _youSave {
    // Calculate savings compared to worst rate (demo: 5% difference)
    return _convertedAmount * 0.019;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: const AnchorAppBar(
        showBackButton: true,
        title: 'Remittance Calculator',
        subtitle: '',
      ),
      endDrawer: const AnchorDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Remittance Calculator',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Compare rates and save on every transfer',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF888888),
              ),
            ),
            const SizedBox(height: 20),
            _buildSummaryCards(),
            const SizedBox(height: 24),
            _buildYouSendSection(),
            const SizedBox(height: 16),
            _buildSwapButton(),
            const SizedBox(height: 16),
            _buildRecipientGetsSection(),
            const SizedBox(height: 20),
            _buildQuickAmounts(),
            const SizedBox(height: 24),
            _buildSortOptions(),
            const SizedBox(height: 20),
            _buildProvidersHeader(),
            const SizedBox(height: 12),
            ..._providers.map((provider) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildProviderCard(provider),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFEEFDF3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF00AA28).withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: const Color(0xFF00AA28),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Best Rate',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF00AA28),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '₱${_bestRate.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF00AA28),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFD7D2E7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.savings_outlined,
                      color: const Color(0xFF3D3790),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'You Save',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3D3790),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '₱${_youSave.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF3D3790),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildYouSendSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'You Send',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF888888),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildCurrencySelector(_fromCurrency, (value) {
                setState(() => _fromCurrency = value);
              }),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A1A),
                  ),
                  decoration: InputDecoration(
                    hintText: _amount.toStringAsFixed(0),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _amount = double.tryParse(value) ?? 1000;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSwapButton() {
    return Center(
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFF3D3790),
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          icon: const Icon(
            Icons.swap_vert,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              final temp = _fromCurrency;
              _fromCurrency = _toCurrency;
              _toCurrency = temp;
            });
          },
        ),
      ),
    );
  }

  Widget _buildRecipientGetsSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEEFDF3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF00AA28).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recipient Gets',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF00AA28),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildCurrencySelector(_toCurrency, (value) {
                setState(() => _toCurrency = value);
              }),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _convertedAmount.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF00AA28),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencySelector(String currency, Function(String) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: DropdownButton<String>(
        value: currency,
        underline: const SizedBox(),
        isDense: true,
        items: ['SGD', 'PHP', 'USD', 'MYR'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: [
                Text(
                  _getCurrencyFlag(value),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 6),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) onChanged(value);
        },
      ),
    );
  }

  String _getCurrencyFlag(String currency) {
    switch (currency) {
      case 'SGD':
        return '🇸🇬';
      case 'PHP':
        return '🇵🇭';
      case 'USD':
        return '🇺🇸';
      case 'MYR':
        return '🇲🇾';
      default:
        return '🌍';
    }
  }

  Widget _buildQuickAmounts() {
    final amounts = [500.0, 1000.0, 2000.0, 5000.0];
    return Row(
      children: amounts.map((amount) {
        final isSelected = _amount == amount;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: InkWell(
              onTap: () => setState(() => _amount = amount),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF3D3790)
                      : const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'S\$${amount.toInt()}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : const Color(0xFF888888),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSortOptions() {
    final options = ['Best Value', 'Fastest', 'Cheapest'];
    return Row(
      children: [
        const Text(
          'Sort by:',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF888888),
          ),
        ),
        const SizedBox(width: 12),
        ...options.map((option) {
          final isSelected = _sortBy == option;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () => setState(() => _sortBy = option),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF3D3790)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF3D3790)
                        : const Color(0xFFE0E0E0),
                  ),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color:
                        isSelected ? Colors.white : const Color(0xFF888888),
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildProvidersHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${_providers.length} Providers Found',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
        TextButton.icon(
          onPressed: () {
            setState(() {
              // Trigger refresh animation
            });
          },
          icon: const Icon(
            Icons.refresh,
            size: 16,
            color: Color(0xFF3D3790),
          ),
          label: const Text(
            'Refresh Rates',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF3D3790),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProviderCard(Map<String, dynamic> provider) {
    final youGet = _convertedAmount - provider['fee'];
    final isRecommended = provider['recommended'] as bool;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isRecommended
            ? Border.all(color: const Color(0xFF00AA28), width: 2)
            : null,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          if (isRecommended)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: const BoxDecoration(
                color: Color(0xFF00AA28),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.verified,
                    color: Colors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'BEST VALUE - Recommended',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.account_balance_wallet,
                        color: Color(0xFF3D3790),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 14,
                                color: Color(0xFFFFA726),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${provider['rating']} (${provider['reviews']} reviews)',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF888888),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildInfoColumn(
                      '₱${youGet.toStringAsFixed(2)}',
                      'You Get',
                    ),
                    _buildInfoColumn(
                      'S\$${provider['fee']}',
                      'Fee',
                    ),
                    _buildInfoColumn(
                      provider['speed'],
                      'Speed',
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: (provider['tags'] as List<String>).map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD7D2E7),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF3D3790),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                if (provider['discount'] != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3F3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      provider['discount'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8E0012),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Opening ${provider['name']} transfer...'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3D3790),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Send Money',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(Icons.arrow_forward, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF888888),
          ),
        ),
      ],
    );
  }
}
