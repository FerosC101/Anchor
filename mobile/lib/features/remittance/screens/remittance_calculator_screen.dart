import 'package:flutter/material.dart';
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
      'name': 'Remitly',
      'rating': 4.6,
      'reviews': 1234,
      'fee': 3.99,
      'speed': '1H',
      'tags': ['Express Delivery', 'Trusted', 'Low fees'],
      'discount': null,
      'recommended': true,
    },
    {
      'name': 'Remitly',
      'rating': 4.6,
      'reviews': 1234,
      'fee': 3.99,
      'speed': '1H',
      'tags': ['Express Delivery', 'Trusted', 'Low fees'],
      'discount': null,
      'recommended': false,
    },
    {
      'name': 'Remitly',
      'rating': 4.6,
      'reviews': 1234,
      'fee': 3.99,
      'speed': '1H',
      'tags': ['Express Delivery', 'Trusted', 'Low fees'],
      'discount': null,
      'recommended': false,
    },
    {
      'name': 'Remitly',
      'rating': 4.6,
      'reviews': 1234,
      'fee': 3.99,
      'speed': '1H',
      'tags': ['Express Delivery', 'Trusted', 'Low fees'],
      'discount': null,
      'recommended': false,
    },
    {
      'name': 'Remitly',
      'rating': 4.6,
      'reviews': 1234,
      'fee': 3.99,
      'speed': '1H',
      'tags': ['Express Delivery', 'Trusted', 'Low fees'],
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A1A1A)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Remittance Calculator',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Compare rates and save on every transfer',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF888888),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Color(0xFF1A1A1A)),
            onPressed: () {},
          ),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Color(0xFF1A1A1A)),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      endDrawer: const AnchorDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            
            // Calculator Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // You Send
                  const Text(
                    'You Send',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildCurrencyDropdown(_fromCurrency, (value) {
                        setState(() => _fromCurrency = value);
                      }),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1A1A),
                          ),
                          decoration: InputDecoration(
                            hintText: _amount.toStringAsFixed(0),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
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
                  const SizedBox(height: 20),
                  
                  // Swap Button
                  Center(
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF3D3790),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.swap_vert,
                          color: Colors.white,
                          size: 24,
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
                  ),
                  const SizedBox(height: 20),
                  
                  // Recipient Gets
                  const Text(
                    'Recipient Gets',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildCurrencyDropdown(_toCurrency, (value) {
                        setState(() => _toCurrency = value);
                      }),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _convertedAmount.toStringAsFixed(0),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Providers Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    '5 Providers found',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Sort Dropdown
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.sort, size: 20, color: Color(0xFF888888)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButton<String>(
                        value: _sortBy,
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: ['Best Value', 'Fastest', 'Cheapest'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1A1A1A),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _sortBy = value);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Provider Cards
            ...List.generate(_providers.length, (index) {
              final provider = _providers[index];
              final isFirst = index == 0;
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: _buildProviderCard(provider, isFirst),
              );
            }),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyDropdown(String currency, Function(String) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: currency,
        underline: const SizedBox(),
        isDense: true,
        items: ['SGD', 'PHP', 'USD', 'MYR'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1A),
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) onChanged(value);
        },
      ),
    );
  }

  Widget _buildProviderCard(Map<String, dynamic> provider, bool isRecommended) {
    final youGet = _convertedAmount - provider['fee'];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isRecommended
            ? Border.all(color: const Color(0xFF00C853), width: 2)
            : Border.all(color: const Color(0xFFE0E0E0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
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
                color: Color(0xFFE8F5E9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
              ),
              child: const Text(
                'Best Value - Recommended',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF00C853),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Provider Header
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF5E4DBD),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.account_balance_wallet_outlined,
                        color: Colors.white,
                        size: 24,
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
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 16,
                                color: Color(0xFFFFA726),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${provider['rating']}  (${provider['reviews']} reviews)',
                                style: const TextStyle(
                                  fontSize: 13,
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
                
                const SizedBox(height: 20),
                
                // Info Cards: You Get, Fee, Speed
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'You get',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF888888),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${youGet.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF3D3790),
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
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Fee',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF888888),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '\$${provider['fee'].toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF3D3790),
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
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Speed',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF888888),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              provider['speed'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF3D3790),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (provider['tags'] as List<String>).map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF888888),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                
                const SizedBox(height: 16),
                
                // Send Money Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Opening ${provider['name']} transfer...'),
                          backgroundColor: const Color(0xFF3D3790),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3D3790),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Send Money',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
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
}
