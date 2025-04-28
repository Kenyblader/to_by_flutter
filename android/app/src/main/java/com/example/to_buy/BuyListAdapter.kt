package com.example.to_buy

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class BuyListAdapter(private val buyLists: List<BuyList>) :
    RecyclerView.Adapter<BuyListAdapter.BuyListViewHolder>() {

    class BuyListViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        val title: TextView = view.findViewById(R.id.listTitle)
        val description: TextView = view.findViewById(R.id.listDescription)
        val statusIcon: ImageView = view.findViewById(R.id.listStatusIcon)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): BuyListViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.item_buy_list, parent, false)
        return BuyListViewHolder(view)
    }

    override fun onBindViewHolder(holder: BuyListViewHolder, position: Int) {
        val buyList = buyLists[position]
        holder.title.text = buyList.name
        holder.description.text = buyList.description
        if (buyList.isComplete) {
            holder.statusIcon.setImageResource(R.drawable.icon_checked) // ✅
        } else {
            holder.statusIcon.setImageResource(R.drawable.icon_cancel) // ❌
        }
    }

    override fun getItemCount() = buyLists.size
}
