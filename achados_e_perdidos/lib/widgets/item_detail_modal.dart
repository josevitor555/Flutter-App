import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ahadoseperdidos/core/app_colors.dart';
import 'package:ahadoseperdidos/models/lost_item.dart';

/// Modal que exibe detalhes completos de um item perdido ou encontrado.
/// Mini banner (imagem), nome, descrição, categoria, localização e status.
class ItemDetailModal extends StatelessWidget {
  final LostItem item;

  const ItemDetailModal({Key? key, required this.item}) : super(key: key);

  static Future<void> show(BuildContext context, LostItem item) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ItemDetailModal(item: item),
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = item.isFound
        ? AppColors.statusFound
        : AppColors.statusLost;

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (_, scrollController) => Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 24,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildHandle(),
            Expanded(
              child: ListView(
                controller: scrollController,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                children: [
                  _buildMiniBanner(),
                  const SizedBox(height: 20),
                  _buildStatusBadge(statusColor),
                  const SizedBox(height: 16),
                  _buildTitle(),
                  if (item.description != null &&
                      item.description!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    _buildSection('Descrição', item.description!),
                  ],
                  if (item.category != null && item.category!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _buildSection('Categoria', item.category!),
                  ],
                  if (item.location != null && item.location!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _buildLocationSection(),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 8),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildMiniBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: CachedNetworkImage(
          imageUrl: item.imageUrl ?? '',
          fit: BoxFit.cover,
          placeholder: (_, __) => Container(
            color: Colors.grey.shade200,
            child: Icon(
              Icons.image_outlined,
              size: 48,
              color: Colors.grey.shade400,
            ),
          ),
          errorWidget: (_, __, ___) => Container(
            color: Colors.grey.shade200,
            child: Icon(
              Icons.broken_image_outlined,
              size: 48,
              color: Colors.grey.shade400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(Color statusColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            item.isFound ? Icons.check_circle_outline : Icons.info_outline,
            color: statusColor,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            item.statusLabel,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: statusColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      item.title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.black,
      ),
    );
  }

  Widget _buildSection(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.grey,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(fontSize: 16, color: AppColors.black, height: 1.4),
        ),
      ],
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Localização',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.grey,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 20,
              color: AppColors.primary,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                item.location!,
                style: TextStyle(fontSize: 16, color: AppColors.black),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
